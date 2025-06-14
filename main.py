import json
import requests
import subprocess
import sys

# Load config
with open('config.json') as f:
    config = json.load(f)

API_KEY = config['weather']['api_key']
LAT = config['weather']['latitude']
LON = config['weather']['longitude']
NTFY_TOPIC = config['ntfy']['topic']
NTFY_URL = f"{config['ntfy']['url']}/{NTFY_TOPIC}"

def send_ntfy(message, title):
    headers = {
        "Title": title,
        "Priority": "urgent"
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

def shutdown():
    send_ntfy("Shutting down due to incoming storm.", "Storm Detected")
    subprocess.run(["sudo", "shutdown", "now"])

if __name__ == "__main__":
    try:
        if check_storm():
            shutdown()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)
