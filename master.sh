#!/data/data/com.termux/files/usr/bin/bash
# =============================================================================
#  Project  : Termux-Master-Tool
#  Author   : github.com/tools778
#  Version  : 2.0.0
#  License  : MIT
#  GitHub   : https://github.com/tools778/Termux-Master-Tool
# =============================================================================

# ── COLORS ────────────────────────────────────────────────────────────────────
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
B='\033[0;34m'
C='\033[0;36m'
M='\033[0;35m'
W='\033[1;37m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'

CHECK="${G}✔${RESET}"
CROSS="${R}✘${RESET}"
ARROW="${C}➜${RESET}"
WARN="${Y}⚠${RESET}"
INFO="${B}ℹ${RESET}"
STAR="${M}★${RESET}"

ok()    { echo -e "  ${CHECK} ${G}${1}${RESET}"; }
err()   { echo -e "  ${CROSS} ${R}${1}${RESET}"; }
warn()  { echo -e "  ${WARN}  ${Y}${1}${RESET}"; }
info()  { echo -e "  ${INFO}  ${C}${1}${RESET}"; }
step()  { echo -e "\n  ${ARROW} ${W}${1}${RESET}"; }
pause() { echo ""; read -rp "  Press Enter to continue..."; }

# ── RESPONSIVE DIVIDERS ───────────────────────────────────────────────────────
divider() {
  local w; w=$(tput cols 2>/dev/null || echo 58)
  local line=""; for (( i=2; i<w-1; i++ )); do line+="─"; done
  echo -e "${DIM}  ${line}${RESET}"
}
thin_divider() {
  local w; w=$(tput cols 2>/dev/null || echo 58)
  local line=""; for (( i=2; i<w-1; i++ )); do line+="·"; done
  echo -e "${DIM}  ${line}${RESET}"
}

# ── RESPONSIVE BANNER ─────────────────────────────────────────────────────────
show_banner() {
  clear
  echo ""
  echo -e "  ${M}${BOLD}⚡ TERMUX MASTER TOOL${RESET}  ${DIM}v2.0.0${RESET}"
  divider
  echo -e "  ${DIM}Professional Termux Automation & Package Manager${RESET}"
  echo -e "  ${DIM}github.com/tools778${RESET}"
  divider
  echo ""
}

# =============================================================================
# PRE-FLIGHT
# =============================================================================
check_internet() {
  step "Checking internet..."
  if ping -c 1 -W 3 8.8.8.8 &>/dev/null || ping -c 1 -W 3 1.1.1.1 &>/dev/null; then
    ok "Internet: Active"; return 0
  else
    err "No internet connection!"; warn "Connect to Wi-Fi or mobile data."; return 1
  fi
}

check_pkg() {
  command -v pkg &>/dev/null || { err "pkg not found! Run inside Termux."; exit 1; }
}

# =============================================================================
# MAIN MENU
# =============================================================================
show_menu() {
  echo -e "  ${W}${BOLD}MAIN MENU${RESET}"
  divider
  echo -e "  ${C}[1]${RESET}   System Update & Upgrade"
  echo -e "  ${C}[2]${RESET}   Setup External Repositories"
  echo -e "  ${C}[3]${RESET}   Install Essential 100 Packages"
  echo -e "  ${C}[4]${RESET}   Package Manager          ${DIM}install/remove/search${RESET}"
  echo -e "  ${C}[5]${RESET}   System Info & Monitor    ${DIM}CPU/RAM/battery/processes${RESET}"
  echo -e "  ${C}[6]${RESET}   Network Tools            ${DIM}IP/ping/scan/download${RESET}"
  echo -e "  ${C}[7]${RESET}   Developer Tools          ${DIM}git/ssh/python/node${RESET}"
  echo -e "  ${C}[8]${RESET}   File Manager Tools       ${DIM}backup/clean/extract${RESET}"
  echo -e "  ${C}[9]${RESET}   Fun & Extras             ${DIM}neofetch/matrix/cowsay${RESET}"
  echo -e "  ${C}[10]${RESET}  Count Available Packages"
  divider
  echo -e "  ${R}[0]${RESET}   Exit"
  echo ""
  echo -ne "  ${ARROW} ${W}Choose [0-10]:${RESET} "
}

# =============================================================================
# OPTION 1 — UPDATE & UPGRADE
# =============================================================================
do_update_upgrade() {
  show_banner
  echo -e "  ${W}${BOLD}► System Update & Upgrade${RESET}"
  divider
  check_internet || { pause; return; }

  step "pkg update..."
  pkg update -y
  thin_divider
  step "pkg upgrade..."
  pkg upgrade -y
  thin_divider
  step "Cleaning cache..."
  pkg autoclean -y &>/dev/null && ok "Cache cleaned."
  divider
  echo -e "\n  ${STAR} ${G}${BOLD}System is up to date!${RESET}\n"
  pause
}

# =============================================================================
# OPTION 2 — EXTERNAL REPOS
# =============================================================================
do_setup_repos() {
  show_banner
  echo -e "  ${W}${BOLD}► Setup External Repositories${RESET}"
  divider
  check_internet || { pause; return; }

  step "Updating package lists..."; pkg update -y &>/dev/null && ok "Updated."
  echo ""

  local repos=("x11-repo" "root-repo" "science-repo" "game-repo" "tur-repo")
  local descs=("X11 & Desktop GUI tools" "Root-only tools (needs root)"
    "Scientific computing" "Terminal games" "Termux User Repository")

  for i in "${!repos[@]}"; do
    echo -ne "  ${ARROW} ${W}${repos[$i]}${RESET} ${DIM}(${descs[$i]})${RESET}... "
    pkg install -y "${repos[$i]}" &>/dev/null 2>&1 \
      && echo -e "${CHECK} ${G}Done${RESET}" \
      || echo -e "${WARN} ${Y}Skipped${RESET} ${DIM}(may need root or already installed)${RESET}"
  done

  thin_divider
  step "Syncing repos..."; pkg update -y &>/dev/null && ok "All repos synced."
  divider
  echo -e "\n  ${STAR} ${G}${BOLD}Repositories configured!${RESET}\n"
  pause
}

# =============================================================================
# OPTION 3 — ESSENTIAL 100
# =============================================================================
ESSENTIAL_100=(
  coreutils busybox util-linux findutils diffutils grep sed gawk less pv
  bash zsh fish tmux screen neovim nano micro bat htop
  git git-lfs gh
  python python-pip nodejs npm ruby php perl lua54 golang rust
  clang openjdk-17 kotlin elixir erlang
  make cmake ninja-build autoconf automake pkg-config binutils gdb lldb strace
  curl wget openssh nmap netcat-openbsd socat mtr whois iproute2 dnsutils
  tcpdump aria2 rsync httpie wireguard-tools
  zip unzip p7zip tar gzip xz-utils tree
  sqlite mariadb redis postgresql
  nginx caddy jq yq
  openssl gnupg john hydra
  fzf ripgrep fd-find ranger mc
  ffmpeg imagemagick mpv exiftool sox
  rclone neofetch lolcat figlet cmatrix
)

do_install_essential() {
  show_banner
  echo -e "  ${W}${BOLD}► Install Essential 100 Packages${RESET}"
  divider
  check_internet || { pause; return; }

  local total=${#ESSENTIAL_100[@]}
  local success=0 failed=0 current=0

  info "Total: ${W}${total} packages${RESET}"
  step "Updating lists..."; pkg update -y &>/dev/null && ok "Updated."; echo ""

  for pkg_name in "${ESSENTIAL_100[@]}"; do
    (( current++ ))
    local percent=$(( current * 100 / total ))
    local filled=$(( current * 20 / total ))
    local bar=""
    for (( i=0; i<filled; i++ )); do bar+="█"; done
    for (( i=filled; i<20; i++ )); do bar+="░"; done

    printf "  ${C}[%s]${RESET} ${W}%3d%%${RESET} %-22s" "$bar" "$percent" "$pkg_name"
    if pkg install -y "$pkg_name" &>/dev/null 2>&1; then
      echo -e " ${CHECK}"; (( success++ ))
    else
      echo -e " ${CROSS}"; (( failed++ ))
    fi
  done

  divider
  echo -e "  ${G}Installed: ${success}${RESET}  ${R}Failed: ${failed}${RESET}  ${C}Total: ${current}${RESET}"
  divider; echo -e "\n  ${STAR} ${G}${BOLD}Done!${RESET}\n"; pause
}

# =============================================================================
# OPTION 4 — PACKAGE MANAGER
# =============================================================================
do_package_manager() {
  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► Package Manager${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  Install a package"
    echo -e "  ${C}[2]${RESET}  Remove a package"
    echo -e "  ${C}[3]${RESET}  Search packages"
    echo -e "  ${C}[4]${RESET}  Show package info"
    echo -e "  ${C}[5]${RESET}  List installed packages"
    echo -e "  ${C}[6]${RESET}  List upgradeable packages"
    echo -e "  ${C}[7]${RESET}  Clean package cache"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1)
        echo -ne "\n  ${ARROW} ${W}Package name:${RESET} "; read -r p
        [[ -z "$p" ]] && continue
        pkg install -y "$p" && ok "$p installed." || err "Failed."
        pause ;;
      2)
        echo -ne "\n  ${ARROW} ${W}Package to remove:${RESET} "; read -r p
        [[ -z "$p" ]] && continue
        echo -ne "  ${WARN} ${Y}Remove $p? [y/N]:${RESET} "; read -r c
        [[ "$c" =~ ^[Yy]$ ]] && { pkg uninstall -y "$p" && ok "Removed." || err "Failed."; } || info "Cancelled."
        pause ;;
      3)
        echo -ne "\n  ${ARROW} ${W}Search query:${RESET} "; read -r q
        [[ -z "$q" ]] && continue; echo ""
        pkg search "$q" 2>/dev/null || apt-cache search "$q"; pause ;;
      4)
        echo -ne "\n  ${ARROW} ${W}Package name:${RESET} "; read -r p
        [[ -z "$p" ]] && continue; echo ""
        pkg show "$p" 2>/dev/null || apt-cache show "$p"; pause ;;
      5)
        echo ""; dpkg -l | grep "^ii" | awk '{printf "  %-30s %s\n",$2,$3}' | less ;;
      6)
        step "Checking upgrades..."; pkg update -y &>/dev/null
        apt list --upgradable 2>/dev/null | grep -v "Listing"; pause ;;
      7)
        step "Cleaning..."; pkg autoclean -y &>/dev/null; pkg clean -y &>/dev/null
        ok "Cache cleaned."; pause ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 5 — SYSTEM INFO & MONITOR
# =============================================================================
do_system_info() {
  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► System Info & Monitor${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  Full system overview"
    echo -e "  ${C}[2]${RESET}  CPU info & frequency"
    echo -e "  ${C}[3]${RESET}  RAM / Memory usage"
    echo -e "  ${C}[4]${RESET}  Storage / Disk usage"
    echo -e "  ${C}[5]${RESET}  Battery status"
    echo -e "  ${C}[6]${RESET}  Running processes (top 20)"
    echo -e "  ${C}[7]${RESET}  Uptime & load average"
    echo -e "  ${C}[8]${RESET}  Android & device info"
    echo -e "  ${C}[9]${RESET}  Live monitor (htop)"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1)
        show_banner; echo -e "  ${W}${BOLD}System Overview${RESET}"; divider; echo ""
        echo -e "  ${C}Hostname   :${RESET} $(hostname 2>/dev/null || echo N/A)"
        echo -e "  ${C}Android    :${RESET} $(getprop ro.build.version.release 2>/dev/null || echo N/A)"
        echo -e "  ${C}Device     :${RESET} $(getprop ro.product.model 2>/dev/null || echo N/A)"
        echo -e "  ${C}Kernel     :${RESET} $(uname -r)"
        echo -e "  ${C}Arch       :${RESET} $(uname -m)"
        local cpu; cpu=$(grep -m1 "Hardware\|model name\|Processor" /proc/cpuinfo 2>/dev/null | cut -d: -f2 | xargs)
        echo -e "  ${C}CPU        :${RESET} ${cpu:-N/A}"
        echo -e "  ${C}CPU Cores  :${RESET} $(grep -c '^processor' /proc/cpuinfo 2>/dev/null)"
        local mt ma
        mt=$(grep MemTotal     /proc/meminfo 2>/dev/null | awk '{printf "%.1f GB",$2/1024/1024}')
        ma=$(grep MemAvailable /proc/meminfo 2>/dev/null | awk '{printf "%.1f GB",$2/1024/1024}')
        echo -e "  ${C}RAM Total  :${RESET} ${mt}"
        echo -e "  ${C}RAM Free   :${RESET} ${ma}"
        local di; di=$(df -h "$HOME" 2>/dev/null | awk 'NR==2{print $2" total | "$3" used | "$4" free"}')
        echo -e "  ${C}Storage    :${RESET} ${di}"
        echo -e "  ${C}Uptime     :${RESET} $(uptime -p 2>/dev/null || uptime)"
        divider; pause ;;
      2)
        show_banner; echo -e "  ${W}${BOLD}CPU Info${RESET}"; divider; echo ""
        grep -E "processor|Hardware|model name|BogoMIPS" /proc/cpuinfo | sed 's/^/  /'
        echo ""; echo -e "  ${C}Current Frequencies:${RESET}"
        for f in /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq; do
          [[ -f "$f" ]] && printf "    %-10s %d MHz\n" \
            "$(basename $(dirname $(dirname $f))):" "$(( $(cat $f) / 1000 ))"
        done 2>/dev/null
        divider; pause ;;
      3)
        show_banner; echo -e "  ${W}${BOLD}Memory Usage${RESET}"; divider; echo ""
        while IFS=: read -r k v; do
          k=$(echo "$k"|xargs); v=$(echo "$v"|xargs)
          case "$k" in
            MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree)
              printf "  ${C}%-15s${RESET} %-12s ${DIM}(~%d MB)${RESET}\n" \
                "$k" "${v%% *} kB" "$(( ${v%% *} / 1024 ))" ;;
          esac
        done < /proc/meminfo
        divider; pause ;;
      4)
        show_banner; echo -e "  ${W}${BOLD}Disk Usage${RESET}"; divider; echo ""
        df -h 2>/dev/null | awk 'NR==1{printf "  %-22s %5s %5s %5s %4s\n",$1,$2,$3,$4,$5}
          NR>1{printf "  %-22s %5s %5s %5s %4s\n",$1,$2,$3,$4,$5}'
        echo ""; thin_divider
        echo -e "  ${W}Termux HOME:${RESET}"; du -sh "$HOME" 2>/dev/null | sed 's/^/  /'
        divider; pause ;;
      5)
        show_banner; echo -e "  ${W}${BOLD}Battery Status${RESET}"; divider; echo ""
        if command -v termux-battery-status &>/dev/null; then
          termux-battery-status 2>/dev/null | sed 's/[{}]//g;s/,/\n/g;/^$/d' | sed 's/^/  /'
        else
          local bp="/sys/class/power_supply/battery"
          if [[ -d "$bp" ]]; then
            [[ -f "$bp/capacity" ]] && echo -e "  ${C}Level  :${RESET} $(cat $bp/capacity)%"
            [[ -f "$bp/status" ]]   && echo -e "  ${C}Status :${RESET} $(cat $bp/status)"
            [[ -f "$bp/health" ]]   && echo -e "  ${C}Health :${RESET} $(cat $bp/health)"
            [[ -f "$bp/temp" ]]     && echo -e "  ${C}Temp   :${RESET} $(echo "scale=1; $(cat $bp/temp)/10" | bc)°C"
          else
            warn "Install termux-api for battery info:"; info "pkg install termux-api"
          fi
        fi
        divider; pause ;;
      6)
        show_banner; echo -e "  ${W}${BOLD}Top 20 Processes${RESET}"; divider; echo ""
        ps aux 2>/dev/null | head -21 | awk '{printf "  %-8s %-6s %-5s %-5s %s\n",$1,$2,$3,$4,$11}' \
          || top -bn1 | head -25 | sed 's/^/  /'
        divider; pause ;;
      7)
        show_banner; echo -e "  ${W}${BOLD}Uptime & Load${RESET}"; divider; echo ""
        echo -e "  ${C}Uptime :${RESET} $(uptime -p 2>/dev/null || uptime)"
        echo -e "  ${C}Load   :${RESET} $(cat /proc/loadavg)"
        divider; pause ;;
      8)
        show_banner; echo -e "  ${W}${BOLD}Android & Device Info${RESET}"; divider; echo ""
        echo -e "  ${C}Android Version :${RESET} $(getprop ro.build.version.release 2>/dev/null)"
        echo -e "  ${C}SDK Level       :${RESET} $(getprop ro.build.version.sdk 2>/dev/null)"
        echo -e "  ${C}Device Model    :${RESET} $(getprop ro.product.model 2>/dev/null)"
        echo -e "  ${C}Manufacturer    :${RESET} $(getprop ro.product.manufacturer 2>/dev/null)"
        echo -e "  ${C}Brand           :${RESET} $(getprop ro.product.brand 2>/dev/null)"
        echo -e "  ${C}Build ID        :${RESET} $(getprop ro.build.id 2>/dev/null)"
        echo -e "  ${C}Kernel          :${RESET} $(uname -r)"
        echo -e "  ${C}Architecture    :${RESET} $(uname -m)"
        divider; pause ;;
      9)
        command -v htop &>/dev/null || pkg install htop -y
        htop ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 6 — NETWORK TOOLS
# =============================================================================
do_network_tools() {
  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► Network Tools${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  Show IP addresses (local + public)"
    echo -e "  ${C}[2]${RESET}  Ping a host"
    echo -e "  ${C}[3]${RESET}  DNS lookup"
    echo -e "  ${C}[4]${RESET}  Traceroute"
    echo -e "  ${C}[5]${RESET}  Port scan (nmap)"
    echo -e "  ${C}[6]${RESET}  Active connections"
    echo -e "  ${C}[7]${RESET}  WiFi info"
    echo -e "  ${C}[8]${RESET}  Download a file"
    echo -e "  ${C}[9]${RESET}  SSH connect"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1)
        show_banner; echo -e "  ${W}${BOLD}IP Addresses${RESET}"; divider; echo ""
        echo -e "  ${C}Local IPs:${RESET}"
        ip addr show 2>/dev/null | grep "inet " | awk '{printf "    %-12s %s\n",$NF,$2}' \
          || ifconfig 2>/dev/null | grep "inet " | awk '{print "    "$2}'
        echo ""; echo -e "  ${C}Public IP:${RESET}"
        echo -n "    "
        curl -s --max-time 5 ifconfig.me 2>/dev/null || curl -s --max-time 5 api.ipify.org || echo "N/A"
        echo ""; divider; pause ;;
      2)
        echo -ne "\n  ${ARROW} ${W}Host:${RESET} "; read -r h; [[ -z "$h" ]] && continue
        echo ""; ping -c 5 "$h" | sed 's/^/  /'; pause ;;
      3)
        echo -ne "\n  ${ARROW} ${W}Domain:${RESET} "; read -r d; [[ -z "$d" ]] && continue; echo ""
        if command -v dig &>/dev/null; then dig "$d" | sed 's/^/  /'
        elif command -v nslookup &>/dev/null; then nslookup "$d" | sed 's/^/  /'
        else pkg install dnsutils -y &>/dev/null && dig "$d"; fi; pause ;;
      4)
        echo -ne "\n  ${ARROW} ${W}Host:${RESET} "; read -r h; [[ -z "$h" ]] && continue; echo ""
        if command -v traceroute &>/dev/null; then traceroute "$h" | sed 's/^/  /'
        elif command -v mtr &>/dev/null; then mtr --report --report-cycles 3 "$h" | sed 's/^/  /'
        else pkg install traceroute -y &>/dev/null && traceroute "$h"; fi; pause ;;
      5)
        echo -ne "\n  ${ARROW} ${W}Target:${RESET} "; read -r t; [[ -z "$t" ]] && continue
        echo -ne "  ${ARROW} ${W}Ports [default: 1-1000]:${RESET} "; read -r p; p=${p:-"1-1000"}; echo ""
        command -v nmap &>/dev/null || pkg install nmap -y &>/dev/null
        nmap -p "$p" "$t" | sed 's/^/  /'; pause ;;
      6)
        show_banner; echo -e "  ${W}${BOLD}Active Connections${RESET}"; divider; echo ""
        ss -tuln 2>/dev/null | sed 's/^/  /' || netstat -tuln 2>/dev/null | sed 's/^/  /'
        divider; pause ;;
      7)
        show_banner; echo -e "  ${W}${BOLD}WiFi Info${RESET}"; divider; echo ""
        if command -v termux-wifi-connectioninfo &>/dev/null; then
          termux-wifi-connectioninfo | sed 's/^/  /'
        else
          warn "Install termux-api:"; info "pkg install termux-api"
          ip link show 2>/dev/null | grep -E "wlan|rmnet" | sed 's/^/  /'
        fi
        divider; pause ;;
      8)
        echo -ne "\n  ${ARROW} ${W}URL:${RESET} "; read -r u; [[ -z "$u" ]] && continue
        echo -ne "  ${ARROW} ${W}Filename [auto]:${RESET} "; read -r f; f=${f:-$(basename "$u")}; echo ""
        command -v wget &>/dev/null && wget -O "$f" "$u" || curl -L -o "$f" "$u" --progress-bar
        ok "Saved: $f"; pause ;;
      9)
        echo -ne "\n  ${ARROW} ${W}user@host:${RESET} "; read -r t; [[ -z "$t" ]] && continue
        echo -ne "  ${ARROW} ${W}Port [22]:${RESET} "; read -r p; p=${p:-22}
        command -v ssh &>/dev/null || pkg install openssh -y
        ssh -p "$p" "$t" ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 7 — DEVELOPER TOOLS
# =============================================================================
do_dev_tools() {
  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► Developer Tools${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  Git setup wizard"
    echo -e "  ${C}[2]${RESET}  Generate SSH key"
    echo -e "  ${C}[3]${RESET}  Clone a GitHub repo"
    echo -e "  ${C}[4]${RESET}  Python virtualenv creator"
    echo -e "  ${C}[5]${RESET}  Node.js project initializer"
    echo -e "  ${C}[6]${RESET}  Install pip packages"
    echo -e "  ${C}[7]${RESET}  Run local web server"
    echo -e "  ${C}[8]${RESET}  View environment variables"
    echo -e "  ${C}[9]${RESET}  Install code-server (VS Code)"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1)
        show_banner; echo -e "  ${W}${BOLD}Git Setup Wizard${RESET}"; divider
        pkg install git -y &>/dev/null
        echo -ne "\n  ${ARROW} ${W}Your Name:${RESET} "; read -r gn
        echo -ne "  ${ARROW} ${W}Your Email:${RESET} "; read -r ge
        [[ -z "$gn" || -z "$ge" ]] && { err "Name & email required."; pause; continue; }
        git config --global user.name "$gn"
        git config --global user.email "$ge"
        git config --global core.editor nano
        git config --global init.defaultBranch main
        git config --global color.ui auto
        echo ""; ok "Git configured!"
        echo -e "  ${C}Name  :${RESET} $(git config --global user.name)"
        echo -e "  ${C}Email :${RESET} $(git config --global user.email)"
        divider; pause ;;
      2)
        show_banner; echo -e "  ${W}${BOLD}Generate SSH Key${RESET}"; divider
        pkg install openssh -y &>/dev/null
        echo -ne "\n  ${ARROW} ${W}Email:${RESET} "; read -r se; [[ -z "$se" ]] && { err "Email required."; pause; continue; }
        echo -ne "  ${ARROW} ${W}Type [ed25519/rsa, default:ed25519]:${RESET} "; read -r kt; kt=${kt:-ed25519}
        echo ""
        ssh-keygen -t "$kt" -C "$se" -f "$HOME/.ssh/id_${kt}"
        echo ""; ok "SSH key generated!"
        thin_divider; echo -e "  ${W}Public key (copy to GitHub):${RESET}\n"
        cat "$HOME/.ssh/id_${kt}.pub" | sed 's/^/  /'
        divider; pause ;;
      3)
        echo -ne "\n  ${ARROW} ${W}Repo URL:${RESET} "; read -r ru; [[ -z "$ru" ]] && continue
        echo -ne "  ${ARROW} ${W}Folder name [auto]:${RESET} "; read -r fo; echo ""
        pkg install git -y &>/dev/null
        [[ -n "$fo" ]] && git clone "$ru" "$fo" || git clone "$ru"
        ok "Cloned."; pause ;;
      4)
        pkg install python -y &>/dev/null
        echo -ne "\n  ${ARROW} ${W}Env name [venv]:${RESET} "; read -r vn; vn=${vn:-venv}; echo ""
        python -m venv "$vn" && ok "Created: ${vn}/"
        echo -e "  ${W}Activate:${RESET} ${C}source ${vn}/bin/activate${RESET}"
        pause ;;
      5)
        pkg install nodejs -y &>/dev/null
        echo -ne "\n  ${ARROW} ${W}Project name:${RESET} "; read -r pn; [[ -z "$pn" ]] && { err "Name required."; pause; continue; }
        mkdir -p "$pn" && cd "$pn" && npm init -y && cd - &>/dev/null
        ok "package.json created in ${pn}/"; pause ;;
      6)
        echo -ne "\n  ${ARROW} ${W}pip package(s):${RESET} "; read -r pp; [[ -z "$pp" ]] && continue
        pkg install python -y &>/dev/null; echo ""; pip install $pp; pause ;;
      7)
        echo -ne "\n  ${ARROW} ${W}Port [8080]:${RESET} "; read -r po; po=${po:-8080}
        echo -ne "  ${ARROW} ${W}Directory [.]:${RESET} "; read -r di; di=${di:-.}; echo ""
        info "http://localhost:${po}  |  Ctrl+C to stop"; echo ""
        pkg install python -y &>/dev/null
        cd "$di" && python -m http.server "$po"; cd - &>/dev/null || true ;;
      8)
        echo ""; env | sort | sed 's/^/  /' | less ;;
      9)
        step "Installing code-server..."
        pkg install tur-repo -y &>/dev/null; pkg update -y &>/dev/null
        pkg install code-server -y && ok "Done! Run: code-server --bind-addr 0.0.0.0:8080" \
          || err "Failed. Try option 2 first (tur-repo)."
        pause ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 8 — FILE MANAGER TOOLS
# =============================================================================
do_file_tools() {
  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► File Manager Tools${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  Disk usage overview"
    echo -e "  ${C}[2]${RESET}  Find top 20 largest files"
    echo -e "  ${C}[3]${RESET}  Clean Termux cache"
    echo -e "  ${C}[4]${RESET}  Backup HOME to /sdcard"
    echo -e "  ${C}[5]${RESET}  Extract archive"
    echo -e "  ${C}[6]${RESET}  Find files by name"
    echo -e "  ${C}[7]${RESET}  Directory tree view"
    echo -e "  ${C}[8]${RESET}  Change file permissions"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1)
        show_banner; echo -e "  ${W}${BOLD}Disk Usage${RESET}"; divider; echo ""
        df -h | sed 's/^/  /'
        echo ""; thin_divider; echo -e "  ${W}Top dirs in HOME:${RESET}\n"
        du -sh "$HOME"/*/  2>/dev/null | sort -rh | head -10 | sed 's/^/  /'
        divider; pause ;;
      2)
        show_banner; echo -e "  ${W}${BOLD}Largest Files${RESET}"; divider
        step "Scanning..."; echo ""
        find "$HOME" -type f -exec du -sh {} + 2>/dev/null | sort -rh | head -20 | sed 's/^/  /'
        divider; pause ;;
      3)
        show_banner; echo -e "  ${W}${BOLD}Clean Cache${RESET}"; divider; echo ""
        local before; before=$(du -sh "$PREFIX/var/cache/apt" 2>/dev/null | cut -f1)
        info "Before: ${before}"
        pkg autoclean -y &>/dev/null; pkg clean -y &>/dev/null
        rm -rf "$PREFIX/var/cache/apt/archives/"*.deb 2>/dev/null
        local after; after=$(du -sh "$PREFIX/var/cache/apt" 2>/dev/null | cut -f1)
        info "After:  ${after}"; ok "Done."
        divider; pause ;;
      4)
        show_banner; echo -e "  ${W}${BOLD}Backup Termux HOME${RESET}"; divider
        local ts; ts=$(date +%Y%m%d_%H%M%S)
        local dest="/sdcard/termux_backup_${ts}.tar.gz"
        echo ""; info "Destination: ${dest}"
        echo -ne "  ${WARN} ${Y}Start backup? [y/N]:${RESET} "; read -r c
        if [[ "$c" =~ ^[Yy]$ ]]; then
          step "Creating backup..."
          tar -czf "$dest" -C "$HOME" . 2>/dev/null
          [[ -f "$dest" ]] && ok "Done: ${dest} ($(du -sh $dest|cut -f1))" \
            || err "Failed. Run: termux-setup-storage"
        else info "Cancelled."; fi
        divider; pause ;;
      5)
        echo -ne "\n  ${ARROW} ${W}Archive path:${RESET} "; read -r ar
        [[ -z "$ar" || ! -f "$ar" ]] && { err "File not found."; pause; continue; }
        echo -ne "  ${ARROW} ${W}Extract to [.]:${RESET} "; read -r dd; dd=${dd:-.}; mkdir -p "$dd"; echo ""
        case "$ar" in
          *.tar.gz|*.tgz) tar -xzf "$ar" -C "$dd" ;;
          *.tar.bz2)      tar -xjf "$ar" -C "$dd" ;;
          *.tar.xz)       tar -xJf "$ar" -C "$dd" ;;
          *.tar)          tar -xf  "$ar" -C "$dd" ;;
          *.zip)          unzip "$ar" -d "$dd" ;;
          *.7z)           7z x "$ar" -o"$dd" ;;
          *.gz)           gunzip -k "$ar" ;;
          *)              err "Unknown format." ;;
        esac
        ok "Extracted to: ${dd}"; pause ;;
      6)
        echo -ne "\n  ${ARROW} ${W}Filename to find:${RESET} "; read -r fn; [[ -z "$fn" ]] && continue; echo ""
        find "$HOME" -name "*${fn}*" 2>/dev/null | sed 's/^/  /'; pause ;;
      7)
        command -v tree &>/dev/null || pkg install tree -y &>/dev/null
        echo -ne "\n  ${ARROW} ${W}Directory [HOME]:${RESET} "; read -r dr; dr=${dr:-"$HOME"}; echo ""
        tree -L 3 "$dr" 2>/dev/null | head -60 | sed 's/^/  /'; pause ;;
      8)
        echo -ne "\n  ${ARROW} ${W}File path:${RESET} "; read -r fp
        [[ -z "$fp" || ! -e "$fp" ]] && { err "Not found."; pause; continue; }
        echo ""; ls -la "$fp" | sed 's/^/  /'; echo ""
        echo -ne "  ${ARROW} ${W}New permissions (e.g. 755) or Enter to skip:${RESET} "; read -r pm
        [[ -n "$pm" ]] && chmod "$pm" "$fp" && ok "Permissions set to ${pm}."
        pause ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 9 — FUN & EXTRAS
# =============================================================================
do_fun_extras() {
  install_if_missing() { command -v "$1" &>/dev/null || pkg install -y "$1" &>/dev/null; }

  while true; do
    show_banner
    echo -e "  ${W}${BOLD}► Fun & Extras${RESET}"
    divider
    echo -e "  ${C}[1]${RESET}  neofetch    ${DIM}System info art${RESET}"
    echo -e "  ${C}[2]${RESET}  cmatrix     ${DIM}Matrix rain effect${RESET}"
    echo -e "  ${C}[3]${RESET}  figlet      ${DIM}Big ASCII text${RESET}"
    echo -e "  ${C}[4]${RESET}  lolcat      ${DIM}Rainbow text${RESET}"
    echo -e "  ${C}[5]${RESET}  cowsay      ${DIM}Cow says anything${RESET}"
    echo -e "  ${C}[6]${RESET}  toilet      ${DIM}Fancy text art${RESET}"
    echo -e "  ${C}[7]${RESET}  cbonsai     ${DIM}Animated bonsai tree${RESET}"
    echo -e "  ${C}[8]${RESET}  sl          ${DIM}Steam locomotive${RESET}"
    echo -e "  ${C}[9]${RESET}  Install all fun packages"
    divider; echo -e "  ${R}[0]${RESET}  Back"; echo ""
    echo -ne "  ${ARROW} Choose: "; read -r sub

    case "$sub" in
      1) install_if_missing neofetch; neofetch; pause ;;
      2) install_if_missing cmatrix; cmatrix -a ;;
      3)
        install_if_missing figlet
        echo -ne "\n  ${ARROW} ${W}Text:${RESET} "; read -r t; [[ -z "$t" ]] && continue; echo ""
        figlet "$t" | sed 's/^/  /'; pause ;;
      4)
        install_if_missing lolcat
        echo -ne "\n  ${ARROW} ${W}Text:${RESET} "; read -r t; [[ -z "$t" ]] && continue
        echo "$t" | lolcat; pause ;;
      5)
        install_if_missing cowsay
        echo -ne "\n  ${ARROW} ${W}Message:${RESET} "; read -r t; [[ -z "$t" ]] && continue; echo ""
        cowsay "$t" | sed 's/^/  /'; pause ;;
      6)
        install_if_missing toilet
        echo -ne "\n  ${ARROW} ${W}Text:${RESET} "; read -r t; [[ -z "$t" ]] && continue; echo ""
        toilet -f bigmono12 "$t" 2>/dev/null | lolcat 2>/dev/null || toilet "$t" | sed 's/^/  /'
        pause ;;
      7) install_if_missing cbonsai; cbonsai -l ;;
      8) install_if_missing sl; sl ;;
      9)
        step "Installing all fun packages..."
        for p in neofetch cmatrix figlet lolcat cowsay toilet sl cbonsai; do
          echo -ne "  ${ARROW} ${W}${p}${RESET}... "
          pkg install -y "$p" &>/dev/null && echo -e "${CHECK}" || echo -e "${CROSS}"
        done
        ok "All fun packages done!"; pause ;;
      0) return ;;
      *) err "Invalid."; sleep 1 ;;
    esac
  done
}

# =============================================================================
# OPTION 10 — COUNT PACKAGES
# =============================================================================
do_count_packages() {
  show_banner
  echo -e "  ${W}${BOLD}► Package Count${RESET}"
  divider
  check_internet || { pause; return; }

  step "Refreshing lists..."; pkg update -y &>/dev/null && ok "Updated."; echo ""

  local total installed upgradeable
  total=$(apt-cache pkgnames 2>/dev/null | wc -l)
  installed=$(dpkg -l 2>/dev/null | grep -c "^ii")
  upgradeable=$(apt list --upgradable 2>/dev/null | grep -vc "Listing" || echo 0)

  thin_divider
  echo -e "  ${STAR} ${C}${BOLD}Total Available :${RESET}  ${G}${BOLD}${total}${RESET}"
  echo -e "  ${CHECK} ${W}Installed       :${RESET}  ${G}${installed}${RESET}"
  echo -e "  ${WARN}  ${W}Upgradeable     :${RESET}  ${Y}${upgradeable}${RESET}"
  echo ""; thin_divider
  echo -e "  ${W}${BOLD}Repository Status:${RESET}\n"
  for repo in x11-repo root-repo science-repo game-repo tur-repo; do
    dpkg -l "$repo" 2>/dev/null | grep -q "^ii" \
      && echo -e "  ${CHECK} ${G}${repo}${RESET}  ${DIM}active${RESET}" \
      || echo -e "  ${CROSS} ${DIM}${repo}${RESET}  ${DIM}not installed${RESET}"
  done
  echo ""; thin_divider
  echo -e "  ${DIM}Tip: Option 2 adds more repos → more packages${RESET}"
  divider; pause
}

# =============================================================================
# EXIT
# =============================================================================
do_exit() {
  echo ""; divider
  echo -e "  ${G}${BOLD}Thanks for using Termux Master Tool! ⚡${RESET}"
  echo -e "  ${DIM}github.com/tools778/Termux-Master-Tool${RESET}"
  echo -e "  ${Y}Star the repo if it helped you! ⭐${RESET}"
  divider; echo ""; exit 0
}

# =============================================================================
# MAIN LOOP
# =============================================================================
main() {
  check_pkg
  show_banner
  echo -e "  ${W}${BOLD}Welcome to Termux Master Tool v2.0.0${RESET}"
  divider; ok "pkg is ready."; sleep 1

  while true; do
    show_banner
    show_menu
    read -r choice

    case "$choice" in
      1)  do_update_upgrade    ;;
      2)  do_setup_repos       ;;
      3)  do_install_essential ;;
      4)  do_package_manager   ;;
      5)  do_system_info       ;;
      6)  do_network_tools     ;;
      7)  do_dev_tools         ;;
      8)  do_file_tools        ;;
      9)  do_fun_extras        ;;
      10) do_count_packages    ;;
      0)  do_exit              ;;
      *)  show_banner; err "Invalid option '${choice}'. Choose 0-10."; sleep 1 ;;
    esac
  done
}

main "$@"
