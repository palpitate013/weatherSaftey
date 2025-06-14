#!/bin/bash
set -e

echo "=== WeatherSaftey ==="

# Ask for config values
read -p "Enter your OpenWeatherMap API Key: " API_KEY
read -p "Enter your latitude (e.g. 35.2271): " LAT
read -p "Enter your longitude (e.g. -80.8431): " LON
read -p "Enter your ntfy topic name (e.g. storm-alert): " TOPIC
read -p "Enter the hostname of the PC to wake: " HOSTNAME
read -p "Enter the MAC address of the PC to wake (e.g. AA:BB:CC:DD:EE:FF): " MAC

# Install wakeonlan
if ! command -v wakeonlan &> /dev/null; then
  echo "Installing wakeonlan..."
  sudo apt update
  sudo apt install -y wakeonlan
fi

# Set up virtual environment
echo "Creating virtual environment..."
python3 -m venv env
source env/bin/activate

# Install dependencies
pip install --upgrade pip
pip install requests

# Write config file
cat > config.json <<EOF
{
  "weather": {
    "api_key": "$API_KEY",
    "latitude": $LAT,
    "longitude": $LON
  },
  "ntfy": {
    "topic": "$TOPIC",
    "url": "https://ntfy.sh"
  },
  "computer": {
    "mac_address": "$MAC",
    "hostname": "$HOSTNAME"
  }
}
EOF

echo "✅ Raspberry Pi setup complete!"
echo "Edit config.json if needed. Activate with: source env/bin/activate"
