#!/bin/bash
set -e

echo "=== WeatherSaftey ==="

# Ask for config values
read -p "Enter your OpenWeatherMap API Key: " API_KEY
read -p "Enter your latitude (e.g. 35.2271): " LAT
read -p "Enter your longitude (e.g. -80.8431): " LON
read -p "Enter your ntfy topic name (e.g. storm-alert): " TOPIC
read -p "Enter your computer hostname: " HOSTNAME
read -p "Enter your computer MAC address (e.g. AA:BB:CC:DD:EE:FF): " MAC

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

echo "✅ PC setup complete!"
echo "Edit config.json if needed. Activate with: source env/bin/activate"
