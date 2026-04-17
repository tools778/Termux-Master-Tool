# ⚡ Termux-Master-Tool

<div align="center">

![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Termux](https://img.shields.io/badge/Platform-Termux-000000?style=for-the-badge&logo=android&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0.0-brightgreen?style=for-the-badge)

**A professional-grade Termux automation tool for GitHub.**  
*Automate updates, repos, and package installs from a single interactive menu.*

</div>

---

## 📋 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Menu Options](#-menu-options)
- [Essential 100 Packages](#-essential-100-packages)
- [File Structure](#-file-structure)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔄 **System Update** | One-click `pkg update && pkg upgrade` with cleanup |
| 📦 **Repo Setup** | Auto-installs x11, root, science, and game repos |
| 🛠️ **Essential 100** | Installs the 100 most-used Termux packages with progress bar |
| 📊 **Package Counter** | Shows total available packages across all active repos |
| 🌈 **Colorized UI** | ANSI color-coded output (green = success, red = error, yellow = warning) |
| 🔌 **Internet Check** | Validates connectivity before any network operation |
| ✅ **pkg Validation** | Ensures pkg is working before running any installation |
| 📈 **Progress Bar** | Real-time progress bar during Essential 100 install |
| 💬 **Interactive Menu** | Clean `case`-based menu, easy to navigate |

---

## 📱 Requirements

- **Android** device running **Termux** (F-Droid version recommended)
- Active internet connection (Wi-Fi or mobile data)
- Minimum **5–10 GB** free storage for full Essential 100 install
- Battery level **≥ 30%** recommended (installation can take time)

> ⚠️ **Note:** `root-repo` requires a rooted device. It will be skipped gracefully on non-rooted devices.

---

## 🚀 Installation

### Method 1 — Clone from GitHub (Recommended)

```bash
# 1. Install git if not already installed
pkg install git -y

# 2. Clone the repository
git clone https://github.com/tools778/Termux-Master-Tool

# 3. Navigate into the directory
cd Termux-Master-Tool

# 4. Make the script executable
chmod +x master.sh

# 5. Run it!
./master.sh
```

### Method 2 — Direct Download

```bash
# Download master.sh directly
curl -fsSL https://raw.githubusercontent.com/tools778/Termux-Master-Tool/main/master.sh -o master.sh

# Make executable and run
chmod +x master.sh && ./master.sh
```

---

## 🎮 Usage

```bash
./master.sh
```

The interactive menu will launch automatically. Use number keys `1–4` to select options, `0` to exit.

---

## 📂 Menu Options

### `[1]` 🔄 Update & Upgrade System
Runs a full system refresh:
```
pkg update → pkg upgrade → pkg autoclean
```
Keeps all installed packages at their latest versions.

---

### `[2]` 📦 Setup External Repositories
Installs all 4 official Termux extra repos:

| Repository | Contents |
|---|---|
| `x11-repo` | GUI/desktop apps, X11 display server tools |
| `root-repo` | Root-only utilities (needs rooted device) |
| `science-repo` | Scientific computing, math, and research tools |
| `game-repo` | Terminal games and entertainment |

After installation, package lists are automatically updated.

---

### `[3]` 🛠️ Install Essential 100
Installs **100 hand-picked, most-used Termux packages** across 11 categories:

- 🔧 Core System Utilities
- 🐚 Shell & Terminal Tools
- 🌿 Version Control
- 💻 Programming Languages (Python, Node.js, PHP, Ruby, Go, Rust, Java, Kotlin, C/C++...)
- 🔨 Build & Dev Tools
- 🌐 Networking Tools
- 🗜️ File & Archive Tools
- 🗄️ Databases
- 🌍 Web & API Tools
- 🔒 Security Tools
- 🎨 Media & Productivity

A real-time **progress bar** shows installation status for each package.

---

### `[4]` 📊 Count Available Packages
Displays:
- Total available packages across all active repos
- Currently installed package count
- Number of upgradeable packages
- Active/inactive status of each extra repository

---

## 📦 Essential 100 Packages

<details>
<summary>Click to expand the full list</summary>

```
Core Utilities    : coreutils, busybox, util-linux, findutils, diffutils,
                    grep, sed, gawk, less, pv
Shell & Terminal  : bash, zsh, fish, tmux, screen, neovim, nano, micro,
                    bat, htop
Version Control   : git, git-lfs, gh
Languages         : python, python-pip, nodejs, npm, ruby, php, perl,
                    lua54, golang, rust, clang, openjdk-17, kotlin,
                    elixir, erlang
Build Tools       : make, cmake, ninja-build, autoconf, automake,
                    pkg-config, binutils, gdb, lldb, strace
Networking        : curl, wget, openssh, nmap, netcat-openbsd, socat,
                    mtr, whois, iproute2, dnsutils, tcpdump, aria2,
                    rsync, httpie, wireguard-tools
File/Archive      : zip, unzip, p7zip, tar, gzip, xz-utils, tree
Databases         : sqlite, mariadb, redis, postgresql, mongodb
Web & API         : nginx, apache2, caddy, jq, yq
Security          : openssl, gnupg, john, hydra, ncrack
File Management   : fzf, ripgrep, fd-find, ranger, mc
Media             : ffmpeg, imagemagick, mpv, exiftool, sox
Productivity      : rclone, neofetch, lolcat, figlet, cmatrix
```

</details>

---

## 🗂️ File Structure

```
Termux-Master-Tool/
├── master.sh          # Main interactive script
├── README.md          # This documentation
├── LICENSE            # MIT License
└── requirements.txt   # Package references (for GitHub standards)
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ❤️ for the Termux community  
⭐ **Star this repo** if it helped you!

</div>
