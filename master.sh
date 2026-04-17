#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════════════════════════
#   ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗
#      ██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝
#      ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝
#      ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗
#      ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗
#      ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝
#
#   ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗
#   ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗
#   ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝
#   ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗
#   ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║
#   ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝
#
#   ████████╗ ██████╗  ██████╗ ██╗
#      ██╔══╝██╔═══██╗██╔═══██╗██║
#      ██║   ██║   ██║██║   ██║██║
#      ██║   ██║   ██║██║   ██║██║
#      ██║   ╚██████╔╝╚██████╔╝███████╗
#      ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
#
# ═══════════════════════════════════════════════════════════════════════════════
#  Project  : Termux-Master-Tool
#  Author   : github.com/tools778
#  Version  : 1.0.0
#  License  : MIT
#  GitHub   : https://github.com/tools778/Termux-Master-Tool
# ═══════════════════════════════════════════════════════════════════════════════

# ── ANSI COLOR CODES ──────────────────────────────────────────────────────────
R='\033[0;31m'       # Red
G='\033[0;32m'       # Green
Y='\033[1;33m'       # Yellow
B='\033[0;34m'       # Blue
C='\033[0;36m'       # Cyan
M='\033[0;35m'       # Magenta
W='\033[1;37m'       # White Bold
DIM='\033[2m'        # Dim
BOLD='\033[1m'
RESET='\033[0m'

# ── SYMBOLS ───────────────────────────────────────────────────────────────────
CHECK="${G}✔${RESET}"
CROSS="${R}✘${RESET}"
ARROW="${C}➜${RESET}"
WARN="${Y}⚠${RESET}"
INFO="${B}ℹ${RESET}"
STAR="${M}★${RESET}"

# ── LOGGING HELPERS ───────────────────────────────────────────────────────────
ok()   { echo -e "  ${CHECK} ${G}${1}${RESET}"; }
err()  { echo -e "  ${CROSS} ${R}${1}${RESET}"; }
warn() { echo -e "  ${WARN}  ${Y}${1}${RESET}"; }
info() { echo -e "  ${INFO}  ${C}${1}${RESET}"; }
step() { echo -e "\n  ${ARROW} ${W}${1}${RESET}"; }

# ── DIVIDER ───────────────────────────────────────────────────────────────────
divider() {
  echo -e "${DIM}  ──────────────────────────────────────────────────────────${RESET}"
}

thin_divider() {
  echo -e "${DIM}  · · · · · · · · · · · · · · · · · · · · · · · · · · · · ·${RESET}"
}

# =============================================================================
# BANNER
# =============================================================================
show_banner() {
  clear
  echo ""
  echo -e "${B}${BOLD}  ╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${B}${BOLD}  ║${RESET}  ${M}${BOLD}⚡ TERMUX MASTER TOOL${RESET}  ${DIM}v1.0.0${RESET}                         ${B}${BOLD}║${RESET}"
  echo -e "${B}${BOLD}  ║${RESET}  ${DIM}Professional Termux Automation & Package Manager${RESET}       ${B}${BOLD}║${RESET}"
  echo -e "${B}${BOLD}  ║${RESET}  ${DIM}github.com/tools778${RESET}                                   ${B}${BOLD}║${RESET}"
  echo -e "${B}${BOLD}  ╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
}

# =============================================================================
# MAIN MENU
# =============================================================================
show_menu() {
  echo -e "${W}${BOLD}  MAIN MENU${RESET}"
  divider
  echo -e "  ${C}[1]${RESET}  ${W}System Update & Upgrade${RESET}           ${DIM}Update all packages${RESET}"
  echo -e "  ${C}[2]${RESET}  ${W}Setup External Repositories${RESET}       ${DIM}x11, root, science, game${RESET}"
  echo -e "  ${C}[3]${RESET}  ${W}Install Essential 100 Packages${RESET}    ${DIM}Most-used tools & langs${RESET}"
  echo -e "  ${C}[4]${RESET}  ${W}Count Available Packages${RESET}          ${DIM}All repos package count${RESET}"
  divider
  echo -e "  ${R}[0]${RESET}  ${W}Exit${RESET}"
  echo ""
  echo -ne "  ${ARROW} ${W}Choose an option [0-4]:${RESET} "
}

# =============================================================================
# PRE-FLIGHT: INTERNET CHECK
# =============================================================================
check_internet() {
  step "Checking internet connection..."
  if ping -c 1 -W 3 8.8.8.8 &>/dev/null || ping -c 1 -W 3 1.1.1.1 &>/dev/null; then
    ok "Internet connection: Active"
    return 0
  else
    err "No internet connection detected!"
    warn "Please connect to Wi-Fi or mobile data, then try again."
    return 1
  fi
}

# PRE-FLIGHT: CHECK pkg IS WORKING
check_pkg() {
  step "Verifying pkg package manager..."
  if command -v pkg &>/dev/null; then
    ok "pkg is available and working."
    return 0
  else
    err "pkg not found! Are you running this inside Termux?"
    return 1
  fi
}

# =============================================================================
# OPTION 1: UPDATE & UPGRADE
# =============================================================================
do_update_upgrade() {
  show_banner
  echo -e "${W}${BOLD}  ► OPTION 1: System Update & Upgrade${RESET}"
  divider

  check_internet || { read -rp "  Press Enter to return to menu..."; return; }
  check_pkg      || { read -rp "  Press Enter to return to menu..."; return; }

  step "Running pkg update..."
  if pkg update -y; then
    ok "Package lists updated successfully."
  else
    err "pkg update encountered errors."
  fi

  thin_divider
  step "Running pkg upgrade..."
  if pkg upgrade -y; then
    ok "All packages upgraded successfully."
  else
    warn "pkg upgrade finished with some warnings. Check output above."
  fi

  thin_divider
  step "Cleaning up cached package files..."
  pkg autoclean -y &>/dev/null && ok "Cache cleaned."

  divider
  echo -e "\n  ${STAR} ${G}${BOLD}System is up to date!${RESET}\n"
  read -rp "  Press Enter to return to menu..."
}

# =============================================================================
# OPTION 2: SETUP EXTERNAL REPOS
# =============================================================================
do_setup_repos() {
  show_banner
  echo -e "${W}${BOLD}  ► OPTION 2: Setup External Repositories${RESET}"
  divider

  check_internet || { read -rp "  Press Enter to return to menu..."; return; }
  check_pkg      || { read -rp "  Press Enter to return to menu..."; return; }

  # Repo list: name → package
  declare -A REPOS=(
    ["x11-repo"]="X11 & Desktop GUI tools"
    ["root-repo"]="Root-only tools (needs rooted device)"
    ["science-repo"]="Scientific computing packages"
    ["game-repo"]="Terminal games & entertainment"
  )

  step "Updating package lists before repo setup..."
  pkg update -y &>/dev/null && ok "Package lists refreshed."

  echo ""
  for repo in "x11-repo" "root-repo" "science-repo" "game-repo"; do
    desc="${REPOS[$repo]}"
    echo -ne "  ${ARROW} Installing ${W}${repo}${RESET} ${DIM}(${desc})${RESET}... "
    if pkg install -y "$repo" &>/dev/null 2>&1; then
      echo -e "${CHECK} ${G}Done${RESET}"
    else
      echo -e "${WARN}  ${Y}Skipped/Failed${RESET} ${DIM}(may need root or already installed)${RESET}"
    fi
  done

  thin_divider
  step "Refreshing all package lists with new repos..."
  pkg update -y &>/dev/null && ok "All repositories synced."

  divider
  echo -e "\n  ${STAR} ${G}${BOLD}External repositories configured!${RESET}\n"
  read -rp "  Press Enter to return to menu..."
}

# =============================================================================
# OPTION 3: INSTALL ESSENTIAL 100
# =============================================================================

# The Essential 100 - most-used Termux packages
ESSENTIAL_100=(
  # ── Core System Utilities (10) ──────────────────────────────────────────
  coreutils        # GNU core utilities (ls, cp, mv, etc.)
  busybox          # Swiss-army knife for Unix
  util-linux       # Essential Linux system utilities
  findutils        # find, xargs, locate
  diffutils        # diff, cmp, sdiff
  grep             # Pattern matching tool
  sed              # Stream editor
  gawk             # GNU awk
  less             # Terminal pager
  pv               # Pipe Viewer - monitor data progress

  # ── Shell & Terminal (10) ────────────────────────────────────────────────
  bash             # GNU Bourne Again Shell
  zsh              # Z Shell - powerful interactive shell
  fish             # Friendly interactive shell
  tmux             # Terminal multiplexer
  screen           # Terminal session manager
  neovim           # Modern Vim-based editor
  nano             # Simple terminal text editor
  micro            # Modern terminal-based text editor
  bat              # cat with syntax highlighting
  htop             # Interactive process viewer

  # ── Version Control (3) ──────────────────────────────────────────────────
  git              # Distributed version control system
  git-lfs          # Git Large File Storage
  gh               # GitHub CLI

  # ── Programming Languages (15) ───────────────────────────────────────────
  python           # Python 3.x interpreter
  python-pip       # Python package installer
  nodejs           # Node.js JavaScript runtime
  npm              # Node package manager
  ruby             # Ruby programming language
  php              # PHP scripting language
  perl             # Perl programming language
  lua54            # Lua 5.4 interpreter
  golang           # Go programming language
  rust             # Rust programming language
  clang            # C/C++ compiler (LLVM)
  openjdk-17       # Java Development Kit 17
  kotlin           # Kotlin programming language
  elixir           # Elixir functional language
  erlang           # Erlang runtime

  # ── Build & Dev Tools (10) ───────────────────────────────────────────────
  make             # GNU Make build tool
  cmake            # Cross-platform build system
  ninja-build      # Fast build system
  autoconf         # Auto-configure tool
  automake         # Makefile generator
  pkg-config       # Manage compile/link flags
  binutils         # Binary utilities (ld, as, objdump)
  gdb              # GNU Debugger
  lldb             # LLVM Debugger
  strace           # System call tracer

  # ── Networking Tools (15) ────────────────────────────────────────────────
  curl             # Transfer data with URLs
  wget             # Non-interactive network downloader
  openssh          # SSH client & server
  nmap             # Network scanner & security auditor
  netcat-openbsd   # Network utility (TCP/UDP)
  socat            # Multipurpose relay tool
  mtr              # Network diagnostic tool
  whois            # Domain lookup tool
  iproute2         # IP routing utilities
  dnsutils         # DNS lookup utilities (dig, nslookup)
  tcpdump          # Network packet analyzer
  aria2            # Multi-protocol download utility
  rsync            # File synchronization tool
  httpie           # User-friendly HTTP client
  wireguard-tools  # WireGuard VPN tools

  # ── File & Archive Tools (7) ─────────────────────────────────────────────
  zip              # ZIP archiver
  unzip            # ZIP extractor
  p7zip            # 7-Zip archiver
  tar              # Tape archive tool
  gzip             # GNU zip compression
  xz-utils         # XZ compression
  tree             # Directory tree viewer

  # ── Database Tools (5) ───────────────────────────────────────────────────
  sqlite           # Self-contained SQL database
  mariadb          # MySQL-compatible database server
  redis            # In-memory data structure store
  postgresql       # Advanced relational database
  mongodb          # NoSQL document database

  # ── Web & API Tools (5) ──────────────────────────────────────────────────
  nginx            # High-performance web server
  apache2          # Apache HTTP server
  caddy            # Automatic HTTPS web server
  jq               # JSON processor
  yq               # YAML processor

  # ── Security Tools (5) ───────────────────────────────────────────────────
  openssl          # SSL/TLS toolkit
  gnupg            # GNU Privacy Guard encryption
  john             # Password recovery tool
  hydra            # Network login cracker
  ncrack           # High-speed network authentication

  # ── File Management & Search (5) ─────────────────────────────────────────
  fzf              # Fuzzy file finder
  ripgrep          # Fast recursive grep (rg)
  fd-find          # User-friendly find alternative
  ranger           # Console file manager
  mc               # Midnight Commander file manager

  # ── Media & Image Tools (5) ──────────────────────────────────────────────
  ffmpeg           # Multimedia converter
  imagemagick      # Image manipulation tools
  mpv              # Media player
  exiftool         # Read/write EXIF metadata
  sox              # Sound processing tool

  # ── Productivity & Misc (5) ──────────────────────────────────────────────
  rclone           # Cloud storage sync tool
  neofetch         # System info in terminal
  lolcat           # Rainbow output colorizer
  figlet           # Large letter text generator
  cmatrix          # Matrix rain animation
)

do_install_essential() {
  show_banner
  echo -e "${W}${BOLD}  ► OPTION 3: Install The Essential 100${RESET}"
  divider

  check_internet || { read -rp "  Press Enter to return to menu..."; return; }
  check_pkg      || { read -rp "  Press Enter to return to menu..."; return; }

  local total=${#ESSENTIAL_100[@]}
  local success=0
  local failed=0
  local current=0

  info "Total packages to install: ${W}${total}${RESET}"
  thin_divider

  step "Updating package lists first..."
  pkg update -y &>/dev/null && ok "Package lists updated."
  echo ""

  for pkg_name in "${ESSENTIAL_100[@]}"; do
    (( current++ ))

    # Skip comment lines (just for readability - bash ignores them anyway)
    [[ "$pkg_name" == \#* ]] && continue

    local percent=$(( current * 100 / total ))
    local bar_filled=$(( current * 30 / total ))
    local bar=""
    for (( i=0; i<bar_filled; i++ )); do bar+="█"; done
    for (( i=bar_filled; i<30; i++ )); do bar+="░"; done

    printf "  ${C}[%s]${RESET} ${W}%3d%%${RESET}  Installing ${C}%-25s${RESET}" \
      "$bar" "$percent" "$pkg_name"

    if pkg install -y "$pkg_name" &>/dev/null 2>&1; then
      echo -e " ${CHECK}"
      (( success++ ))
    else
      echo -e " ${CROSS} ${DIM}(failed/skipped)${RESET}"
      (( failed++ ))
    fi
  done

  divider
  echo ""
  echo -e "  ${G}${BOLD}✔ Successfully Installed:${RESET}  ${G}${success}${RESET}"
  echo -e "  ${R}${BOLD}✘ Failed / Skipped:${RESET}       ${R}${failed}${RESET}"
  echo -e "  ${C}${BOLD}ℹ Total Attempted:${RESET}        ${W}${current}${RESET}"
  divider
  echo -e "\n  ${STAR} ${G}${BOLD}Essential 100 installation complete!${RESET}\n"
  read -rp "  Press Enter to return to menu..."
}

# =============================================================================
# OPTION 4: COUNT AVAILABLE PACKAGES
# =============================================================================
do_count_packages() {
  show_banner
  echo -e "${W}${BOLD}  ► OPTION 4: Available Package Count${RESET}"
  divider

  check_internet || { read -rp "  Press Enter to return to menu..."; return; }
  check_pkg      || { read -rp "  Press Enter to return to menu..."; return; }

  step "Refreshing all package lists..."
  pkg update -y &>/dev/null && ok "Package lists refreshed."
  echo ""

  thin_divider
  echo -e "  ${W}${BOLD}  Repository Package Counts${RESET}"
  thin_divider

  # Count all packages available via apt/dpkg
  local total
  total=$(apt-cache pkgnames 2>/dev/null | wc -l)

  # Count installed packages
  local installed
  installed=$(dpkg -l 2>/dev/null | grep -c "^ii" || echo "N/A")

  # Count upgradeable
  local upgradeable
  upgradeable=$(apt list --upgradable 2>/dev/null | grep -vc "Listing" || echo "0")

  # Repo-specific counts (best effort)
  local stable_count
  stable_count=$(apt-cache showpkg '*' 2>/dev/null | grep -c "Package:" || echo "N/A")

  echo ""
  echo -e "  ${STAR} ${C}${BOLD}Total Available Packages:${RESET}   ${G}${BOLD}${total}${RESET}"
  echo ""
  echo -e "  ${CHECK} ${W}Currently Installed:${RESET}        ${G}${installed}${RESET}"
  echo -e "  ${WARN}  ${W}Upgradeable:${RESET}                ${Y}${upgradeable}${RESET}"
  echo ""
  thin_divider

  # Check which extra repos are enabled
  echo -e "  ${W}${BOLD}  Extra Repositories Status:${RESET}"
  echo ""

  for repo in "x11-repo" "root-repo" "science-repo" "game-repo" "tur-repo"; do
    if dpkg -l "$repo" 2>/dev/null | grep -q "^ii"; then
      echo -e "  ${CHECK} ${G}${repo}${RESET}  ${DIM}(installed & active)${RESET}"
    else
      echo -e "  ${CROSS} ${DIM}${repo}${RESET}  ${DIM}(not installed)${RESET}"
    fi
  done

  echo ""
  thin_divider
  echo -e "  ${DIM}Note: Run Option 2 to add more repos and increase package count.${RESET}"
  divider
  echo ""
  read -rp "  Press Enter to return to menu..."
}

# =============================================================================
# EXIT
# =============================================================================
do_exit() {
  echo ""
  echo -e "${B}${BOLD}  ╔══════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${B}${BOLD}  ║${RESET}  ${G}Thanks for using Termux Master Tool! ⚡${RESET}               ${B}${BOLD}║${RESET}"
  echo -e "${B}${BOLD}  ║${RESET}  ${DIM}Star the repo on GitHub if this helped you.${RESET}         ${B}${BOLD}║${RESET}"
  echo -e "${B}${BOLD}  ╚══════════════════════════════════════════════════════════╝${RESET}"
  echo ""
  exit 0
}

# =============================================================================
# MAIN LOOP
# =============================================================================
main() {
  # Initial pre-flight checks before showing menu
  show_banner
  echo -e "${W}${BOLD}  Pre-flight System Check${RESET}"
  divider
  check_pkg || exit 1
  echo ""
  sleep 1

  while true; do
    show_banner
    show_menu
    read -r choice

    case "$choice" in
      1) do_update_upgrade   ;;
      2) do_setup_repos      ;;
      3) do_install_essential ;;
      4) do_count_packages   ;;
      0) do_exit             ;;
      *)
        show_banner
        err "Invalid option: '${choice}'. Please choose between 0-4."
        sleep 1
        ;;
    esac
  done
}

# ── Entry point ────────────────────────────────────────────────────────────────
main "$@"
