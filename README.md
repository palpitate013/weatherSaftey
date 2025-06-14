# weatherSaftey

This project automatically shuts down a computer if severe weather is detected and sends an alert via [ntfy.sh](https://ntfy.sh). Once the storm has passed, a Raspberry Pi reboots the system using Wake-on-LAN and sends a notification that it's safe to resume use.

---

## 🚀 Features

- Detects storms using OpenWeatherMap API.
- Sends push notifications via ntfy.
- Automatically shuts down the main computer during severe weather.
- Raspberry Pi reboots the system when it's safe.
- Easy installation and removal via shell scripts.

---

## 📦 Requirements

### PC:
- Python 3.x
- `curl`, `bash`
- Shutdown privileges (`sudo shutdown now`)
- Wake-on-LAN enabled in BIOS and network config

### Raspberry Pi:
- Python 3.x
- `wakeonlan` (will be installed automatically)
- LAN connection to the target machine

---

## 🛠 Installation

> ⚠️ Make sure `python3` and `curl` are available on your system.

### 📥 On the PC:
```bash
curl -sS https://raw.githubusercontent.com/palpitate013/weatherSaftey/main/install_pc.sh | bash
````

### 📥 On the Raspberry Pi:

```bash
curl -sS https://raw.githubusercontent.com/palpitate013/weatherSaftey/main/install_pi.sh | bash
```

After installation, edit the `config.json` file generated in the project folder with your OpenWeatherMap API key, coordinates, and device settings.

---

## 🧹 Uninstall

### ❌ On the PC:

```bash
curl -sS https://raw.githubusercontent.com/your-username/stormshield/main/uninstall_pc.sh | bash
```

### ❌ On the Raspberry Pi:

```bash
curl -sS https://raw.githubusercontent.com/your-username/stormshield/main/uninstall_pi.sh | bash
```

You can also delete `config.json` manually if you want to remove saved credentials and preferences.

---

## ⚙️ Assumptions

* The PC is capable of Wake-on-LAN and it's properly configured.
* The Raspberry Pi is always running and on the same local network as the PC.
* Python scripts are executed in a virtual environment created during install.
* You’ll manually set up scheduled runs (e.g., via cron or systemd) after installation.

---

## 📁 Files

* `install_pc.sh` / `install_pi.sh` – install scripts for each device
* `uninstall_pc.sh` / `uninstall_pi.sh` – cleanup scripts
* `config.json` – editable config file with keys and device info
* `main.py` – PC script to shut down on storms
* `remote.py` – Raspberry Pi script to wake PC when storm passes

---

## 🧠 Tips

* Use [ntfy.sh app](https://ntfy.sh/app/) to receive push alerts.
* Set up `main.py` to run every 10–15 minutes with cron/systemd.
* Run `remote.py` on boot with a lightweight systemd service.

---
