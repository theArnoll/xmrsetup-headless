This file is for Raspberry Pi that runs Ubuntu Server to be configured to an XMRig machine

### What this script does

- Wi-Fi Configuration

- Swappiness (Swap when RAM usage hits 90%)

- Log2Ram

- XMRig ([coin]:[address] haven't set)

- Systemd (make XMRig able to start mining on boot)

- Cockpit

### Instruction:

#### First,

```shell
wget https://raw.githubusercontent.com/theArnoll/rpi-xmrig-setup/main/rpi-xmrig-setup.sh
```

or the short link version:

```shell
wget https://pse.is/xmr-setup
```

I suggest **keeping your monitor connected** during the installation. You will need to note down the IP address displayed at the end of the setup in order to enter your crypto wallet to `~/start-xmrig.sh`.

#### Then,

```shell
chmod +x rpi-xmrig-setup
./rpi-xmrig-setup
```

#### After that,

Enter the Wi-Fi name (SSID) and password to try to connect with Wi-Fi.

Wait until `Setup complete!` shows, and check your Cockpit IP address and note it down. You can now disconnect the monitor.

**You have to** edit `~/start-xmrig.sh` to replace `[coin]:[address]` with your actual wallet details before rebooting in order to start mining.

### Accessing your Pi

The script installs `cockpit` in your Pi. Navigate to `https://[your_raspberry_pi_ip]:9090` in your browser to manage the system, check status, and use the built-in Terminal (just like using PuTTY).

**Note:** You will likely see a "Your connection is not private" warning because Cockpit uses a self-signed certificate. This is normal; please proceed (click "Advanced" > "Proceed to...").

**Login** with your Pi's username and password.

---

#### Tested on

- Ubuntu 22.04 on VMWare (x64, 2 CPUs, 3.5GB RAM (to emulate the real RAM availability of a 4GB Pi))

