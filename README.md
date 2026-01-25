This file is for machines that runs Ubuntu Server to be configured to an XMRig machine

### What this script does

- Wi-Fi Configuration

- Swappiness (Swap when RAM usage hits 90%)

- HugePages (1280 HugePages for better mining performance)

- XMRig ([coin]:[address] haven't set) (Locally built)

- Systemd (make XMRig able to start mining on boot)

- Cockpit

- tailscale

- Log2Ram

### Instruction:

#### First,

```shell
mkdir xmrsetup-headless
cd xmrsetup-headless
wget https://raw.githubusercontent.com/theArnoll/xmrsetup-headless/main/xmr-setup.sh
```

or the short link version:

```shell
mkdir xmrsetup-headless
cd xmrsetup-headless
wget https://pse.is/xmr-setup
```

I suggest **keeping your monitor connected** during the installation. You will need to:

- Enter Wi-Fi SSID and password
- note down the IP address displayed at the end of the setup to enter your crypto wallet to `~/start-xmrig.sh` via cockpit (see [Accessing your machine](#accessing-your-machine)).
- Login tailscale in the end of script (If you don't want to use, you still need to Ctrl+C it)

#### Then,

```shell
chmod +x xmr-setup
./xmr-setup
```

#### After that,

Enter your Linux password to start running the file.

Enter the Wi-Fi name (SSID) and password to try to connect with Wi-Fi.

Wait until `Setup complete!` shows, and check your Cockpit IP address and note it down. You can now disconnect the monitor.

You **have** to edit `~/start-xmrig.sh` to replace `[coin]:[address]` with your actual wallet details before rebooting in order to start mining.

### Accessing your machine

The script installs `cockpit` in your machine. Navigate to `https://[your_machines_ip]:9090` in your browser to manage the system, check status, and use the built-in Terminal (just like using PuTTY).

**Note:** You will likely see a "Your connection is not private" warning because Cockpit uses a self-signed certificate. This is normal; please proceed (click "Advanced" > "Proceed to...").

**Login** with your username and password in your machine.

Thank to tailscale, you can also manage you machine with `cockpit` via Tailscale IP when you're away from the local network of your machine.  
You can find the Tailscale IP (start with 100.×.×.×) by:

- [Tailscale Admin Console](https://login.tailscale.com/admin/machines)
- Running `tailscale ip` in the Terminal of Cockpit or your machine.
- Setup a Discord bot [with the script I wrote](https://github.com/theArnoll/serverboxDCutil) (host on your machine) and send `>server ip` to the server you invite your bot to

---

#### Tested on

- Ubuntu 22.04 on VMWare (x64, 2 CPUs, 3.5GB RAM (to emulate the real RAM availability of a 4GB Pi), 8GB on HDD)
