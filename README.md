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
- Setup a Discord bot [with the script I wrote](https://github.com/theArnoll/serverboxDCutil) (host on your machine) and send `>server ip` to the server you invited your bot to

### Offloading Swap to Another Drive

If you're on a dual boot machine, and you don't want system swap to be stored on the drive where the system you're running ollama at, follow these step:

#### Prerequisite

The target drive must have a swap partition ready.
If the drive you're going to store your swap is running another system as well, you should create a swap partition when installing the system. You may need to reinstall the system if you didn't create one during installation.

The way to create a swap partition when installing system (UEFI, GUI Linux, Ubuntu and Lubuntu tested) is choosing to create partitions yourself when system ask if you want to erase the whole disk, install alongside the system already have or create partition yourself. After that, **choose the correct disk you want to install**, click something like "create a new table", choose "GPT", and start creating partitions.  
Be sure you at least created below partition:

| Size | Format | Mount at | Label |
| - | - | - | - |
| 300MB | FAT32 |  `/boot/efi` |  `boot` |
| As large as you want | ext4 |  `/` | |
| **The swap size you want** | swap | | `swap` |
| ≥ 8MB | unformatted | | `boot` |

After that, you're free to go to the next step.

#### Setting up

- Tested on Ubuntu Server 24.04 installed on USB external 2.5" SSD, Intel N100, 8GB Physical RAM, 8GB swap partition located at internal NVMe m.2 hard drive installed Lubuntu

Follow these step:

1. Find the UUID of the swap partition you made by running `lsblk -f` command in terminal.
2. Look for something like `nvme0n1p3 swap 1 swap xxxx-xxxx-xxxx-xxxx`.
    The `xxxx-xxxx-xxxx-xxxx` is the UUID of the partition. Copy that or note that down
3. Open and edit `/etc/fstab` with root privilege (run `sudo nano /etc/fstab` should work on the most systems)
4. Add this in the end of `/etc/fstab`:
    ```
    UUID=xxxx-xxxx-xxxx-xxxx none swap sw,nofail 0 0
    ```
    Replace the `xxxx-xxxx-xxxx-xxxx` with the UUID you found on step 2.
5. Disable Default Swap (Optional but Recommended): Ubuntu usually creates a default swap file (e.g., /swap.img). To fully move swap to the new drive, comment out the line referencing `/swap.img` in `/etc/fstab` by adding a `#` in front of it.
6. Enable swap by running:
    ``` sh
    sudo swapon -a
    ```
    You can confirm if your swap is configured as the partition you made by running `free -h` and check if the `Swap:` size displayed is as large as the swap partition you made

---

#### Tested on

- Ubuntu 22.04 on VMWare (x64, 2 CPUs, 3.5GB RAM (to emulate the real RAM availability of a 4GB Pi), 8GB on HDD)
- Intel N100 mini PC **`Currently running`** Spec:
  - Intel N100
  - 8GB DDR5
  - 120GB 2.5" SSD (connected via USB)
  - Ubuntu Server 24.04 LTS
