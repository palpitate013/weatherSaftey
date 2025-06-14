import json
import requests
import subprocess
import time
import sys

# Load config
with open('config.json') as f:
    config = json.load(f)

API_KEY = config['weather']['api_key']
LAT = config['weather']['latitude']
LON = config['weather']['longitude']
NTFY_TOPIC = config['ntfy']['topic']
NTFY_URL = f"{config['ntfy']['url']}/{NTFY_TOPIC}"
PC_MAC = config['computer']['mac_address']
PC_NAME = config['computer']['hostname']

def send_ntfy(message, title):
    headers = {
        "Title": title
    }
    response = requests.post(NTFY_URL, headers=headers, data=message)
    response.raise_for_status()

def check_storm():
    url = f"https://api.openweathermap.org/data/2.5/weather?lat={LAT}&lon={LON}&appid={API_KEY}"
    resp = requests.get(url)
    resp.raise_for_status()
    weather = resp.json()
    storm_keywords = ["thunderstorm", "tornado", "storm", "hail"]

    description = weather.get("weather", [{}])[0].get("description", "").lower()
    return any(keyword in description for keyword in storm_keywords)

def wake_pc(mac):
    # Use wakeonlan command line tool (install with: sudo apt install wakeonlan)
    subprocess.run(["wakeonlan", mac])

if __name__ == "__main__":
    try:
        while True:
            if not check_storm():
                wake_pc(PC_MAC)
                send_ntfy(f"{PC_NAME} booting up as storm has passed.", "Storm Over")
                break
            print("Storm still active, checking again in 10 minutes...")
            time.sleep(600)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
