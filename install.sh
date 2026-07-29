#!/bin/bash
# TYPHON DDoS - AUTO INSTALLATION SCRIPT            
# Created by ATHEX BLACK HAT                     


# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[38;2;255;165;0m'
PINK='\033[38;2;255;20;147m'
NEON='\033[38;2;0;255;58m'
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'

# Clear screen
clear

# Animation functions
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

progress_bar() {
    local duration=$1
    local steps=50
    local sleep_time=$(echo "scale=3; $duration / $steps" | bc)
    
    echo -ne "${CYAN}[${RESET}"
    for ((i=0; i<steps; i++)); do
        echo -ne "${GREEN}█${RESET}"
        sleep $sleep_time
    done
    echo -e "${CYAN}]${RESET}"
}

typing_effect() {
    local text="$1"
    local delay=${2:-0.03}
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep $delay
    done
    echo
}

countdown() {
    local seconds=$1
    for ((i=seconds; i>0; i--)); do
        echo -ne "${YELLOW}⏳ Starting in ${RED}$i${YELLOW} seconds...${RESET}\r"
        sleep 1
    done
    echo -ne "\r\033[K"
}

# Banner Animation
show_banner() {
    clear
    echo -e "${PINK}"
    cat << "EOF"
         ████████╗██╗   ██╗██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗  
         ╚══██╔══╝╚██╗ ██╔╝██╔══██╗██║  ██║██╔═══██╗████╗  ██║  
            ██║    ╚████╔╝ ██████╔╝███████║██║   ██║██╔██╗ ██║  
            ██║     ╚██╔╝  ██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║  
            ██║      ██║   ██║     ██║  ██║╚██████╔╝██║ ╚████║  
            ╚═╝      ╚═╝   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝  

EOF
    echo -e "${RESET}"
    echo -e "${CYAN}   ⚡ AUTO INSTALLER v1.0 ⚡${RESET}\n"
    echo -e "${ORANGE}   Developed by ATHEX BLACK HAT${RESET}"
    echo -e "${PINK}$(printf '═%.0s' {1..60})${RESET}\n"
}

# Check system function
check_system() {
    echo -e "${YELLOW}🔍 Checking System Requirements...${RESET}\n"
    
    # Check OS
    echo -ne "${CYAN}[*] Detecting Operating System...${RESET}"
    sleep 0.5
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo -e "${GREEN} ✓ Linux Detected${RESET}"
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "${YELLOW} ⚠ MacOS Detected (Limited Support)${RESET}"
        OS="macos"
    else
        echo -e "${RED} ✗ Unsupported OS${RESET}"
        exit 1
    fi
    
    # Check Python
    echo -ne "${CYAN}[*] Checking Python Installation...${RESET}"
    sleep 0.5
    if command -v python3 &> /dev/null; then
        PYTHON_VERSION=$(python3 --version 2>&1)
        echo -e "${GREEN} ✓ $PYTHON_VERSION${RESET}"
    else
        echo -e "${RED} ✗ Python3 not found!${RESET}"
        echo -e "${YELLOW}[!] Installing Python3...${RESET}"
        if [ "$OS" == "linux" ]; then
            sudo apt-get install python3 python3-pip -y &> /dev/null
        fi
    fi
    
    # Check pip
    echo -ne "${CYAN}[*] Checking pip Installation...${RESET}"
    sleep 0.5
    if command -v pip3 &> /dev/null; then
        PIP_VERSION=$(pip3 --version 2>&1)
        echo -e "${GREEN} ✓ pip Found${RESET}"
    else
        echo -e "${RED} ✗ pip3 not found!${RESET}"
        echo -e "${YELLOW}[!] Installing pip...${RESET}"
        if [ "$OS" == "linux" ]; then
            sudo apt-get install python3-pip -y &> /dev/null
        fi
    fi
    
    # Check git
    echo -ne "${CYAN}[*] Checking Git Installation...${RESET}"
    sleep 0.5
    if command -v git &> /dev/null; then
        echo -e "${GREEN} ✓ Git Found${RESET}"
    else
        echo -e "${YELLOW} ⚠ Git not found (optional)${RESET}"
    fi
    
    echo -e "\n${GREEN}✅ System Check Complete!${RESET}\n"
    sleep 1
}

# Install virtualenv
install_virtualenv() {
    echo -e "${YELLOW}📦 Installing Virtual Environment Tools...${RESET}\n"
    
    echo -ne "${CYAN}[*] Installing virtualenv...${RESET}"
    pip3 install virtualenv &> /dev/null &
    spinner $!
    echo -e "${GREEN} ✓ Done${RESET}"
    
    # Also install virtualenvwrapper for better management
    echo -ne "${CYAN}[*] Installing virtualenvwrapper...${RESET}"
    pip3 install virtualenvwrapper &> /dev/null &
    spinner $!
    echo -e "${GREEN} ✓ Done${RESET}"
    
    echo -e "\n${GREEN}✅ Virtual Environment Tools Installed!${RESET}\n"
    sleep 1
}

# Create and activate virtual environment
setup_virtualenv() {
    echo -e "${YELLOW}🔧 Setting Up Virtual Environment...${RESET}\n"
    
    # Check if athex directory exists
    if [ -d "athex" ]; then
        echo -e "${ORANGE}[!] Virtual environment 'athex' already exists!${RESET}"
        echo -ne "${CYAN}[*] Do you want to recreate it? (y/n): ${RESET}"
        read -r recreate
        if [[ $recreate =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}[*] Removing existing environment...${RESET}"
            rm -rf athex
        else
            echo -e "${GREEN}[✓] Using existing environment${RESET}"
            source athex/bin/activate
            return
        fi
    fi
    
    # Create virtual environment
    echo -e "${PINK}  Creating Virtual Environment: ${BOLD}athex${RESET}"
    
    echo -ne "${CYAN}[*] Creating virtual environment 'athex'...${RESET}"
    virtualenv athex &> /dev/null &
    spinner $!
    echo -e "${GREEN} ✓ Created${RESET}"
    
    # Activate virtual environment
    echo -ne "${CYAN}[*] Activating virtual environment...${RESET}"
    source athex/bin/activate &
    spinner $!
    echo -e "${GREEN} ✓ Activated${RESET}"
    
    # Show environment info
    echo -e "\n${GREEN}📊 Virtual Environment Info:${RESET}"
    echo -e "${CYAN}   • Name:${RESET} ${PINK}athex${RESET}"
    echo -e "${CYAN}   • Python:${RESET} $(which python3)"
    echo -e "${CYAN}   • Version:${RESET} $(python3 --version)"
    echo -e "${CYAN}   • Path:${RESET} $(pwd)/athex"
    
    echo -e "\n${GREEN}✅ Virtual Environment Ready!${RESET}\n"
    sleep 2
}

# Install requirements
install_requirements() {
    echo -e "${YELLOW}📦 Installing Required Packages...${RESET}\n"
    
    # Check if requirements.txt exists
    if [ ! -f "requirements.txt" ]; then
        echo -e "${RED}[✗] requirements.txt not found!${RESET}"
        echo -e "${YELLOW}[!] Creating requirements.txt...${RESET}"
        cat > requirements.txt << 'EOF'
cloudscraper>=1.2.60
socks>=1.0.0
pysocks>=1.7.1
colorama>=0.4.6
httpx>=0.24.0
requests>=2.28.0
urllib3>=1.26.0
certifi>=2023.0.0
chardet>=5.0.0
idna>=3.0.0
cryptography>=39.0.0
pyOpenSSL>=23.0.0
aiohttp>=3.8.0
aiodns>=3.0.0
brotli>=1.0.0
h2>=4.0.0
websockets>=11.0.0
fake-useragent>=1.4.0
psutil>=5.9.0
setuptools>=65.0.0
wheel>=0.38.0
pip>=23.0.0
EOF
        echo -e "${GREEN} ✓ requirements.txt created${RESET}"
    fi
    
    # Update pip first
    echo -e "${CYAN}[1/4] Upgrading pip...${RESET}"
    python3 -m pip install --upgrade pip &> /dev/null &
    spinner $!
    echo -e "${GREEN} ✓ pip upgraded${RESET}"
    
    # Install wheel and setuptools
    echo -e "${CYAN}[2/4] Installing build tools...${RESET}"
    pip3 install wheel setuptools &> /dev/null &
    spinner $!
    echo -e "${GREEN} ✓ Build tools installed${RESET}"
    
    # Install requirements with progress
    echo -e "${CYAN}[3/4] Installing main packages...${RESET}"
    
    # Count total packages
    TOTAL_PACKAGES=$(grep -v '^#' requirements.txt | grep -v '^$' | wc -l)
    CURRENT=0
    
    # Install each package with animation
    while IFS= read -r package || [ -n "$package" ]; do
        # Skip comments and empty lines
        if [[ $package =~ ^#.* ]] || [[ -z $package ]]; then
            continue
        fi
        
        CURRENT=$((CURRENT + 1))
        PACKAGE_NAME=$(echo $package | cut -d'=' -f1)
        
        echo -ne "${CYAN}[${CURRENT}/${TOTAL_PACKAGES}] Installing ${ORANGE}$PACKAGE_NAME${RESET}..."
        
        if pip3 install "$package" &> /dev/null; then
            echo -e "${GREEN} ✓${RESET}"
        else
            echo -e "${RED} ✗ Failed${RESET}"
        fi
        
        sleep 0.1
    done < requirements.txt
    
    echo -e "\n${CYAN}[4/4] Verifying installations...${RESET}"
    
    # Verify key packages
    FAILED=0
    packages=("cloudscraper" "colorama" "httpx" "requests" "socks")
    
    for pkg in "${packages[@]}"; do
        echo -ne "${CYAN}[*] Checking ${pkg}...${RESET}"
        if python3 -c "import $pkg" &> /dev/null; then
            echo -e "${GREEN} ✓${RESET}"
        else
            echo -e "${RED} ✗${RESET}"
            FAILED=1
        fi
        sleep 0.2
    done
    
    if [ $FAILED -eq 0 ]; then
        echo -e "\n${GREEN}✅ All packages installed successfully!${RESET}"
    else
        echo -e "\n${YELLOW}⚠ Some packages failed to install. Try manually.${RESET}"
    fi
    
    echo
    sleep 1
}

# Create activation helper script
create_helper() {
    echo -e "${YELLOW}📝 Creating Helper Scripts...${RESET}\n"
    
    # Create activate script
    cat > activate_athex.sh << 'EOF'
#!/bin/bash
source athex/bin/activate
echo -e "\033[0;32m✅ Virtual environment 'athex' activated!\033[0m"
echo -e "\033[0;36m💡 Type 'deactivate' to exit\033[0m"
EOF
    chmod +x activate_athex.sh
    
    # Create run script
    cat > run_typhon.sh << 'EOF'
#!/bin/bash
source athex/bin/activate
python3 main.py
EOF
    chmod +x run_typhon.sh
    
    echo -e "${GREEN} ✓ activate_athex.sh created${RESET}"
    echo -e "${GREEN} ✓ run_typhon.sh created${RESET}"
    echo
}

# Final message
show_completion() {
    clear
    echo -e "${PINK}"
    cat << "EOF"

     ██████╗  ██████╗ ███╗   ██╗███████╗██╗  
     ██╔══██╗██╔═══██╗████╗  ██║██╔════╝██║  
     ██║  ██║██║   ██║██╔██╗ ██║█████╗  ██║  
     ██║  ██║██║   ██║██║╚██╗██║██╔══╝  ╚═╝  
     ██████╔╝╚██████╔╝██║ ╚████║███████╗██╗  
     ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  
EOF
    echo -e "${RESET}\n"
    
    echo -e "${GREEN}${RESET} ${BOLD}✅ INSTALLATION COMPLETE!${RESET}${GREEN}${RESET}"
    
    echo -e "${CYAN}📋 Quick Start Guide:${RESET}\n"
    echo -e "${YELLOW}  Method 1 - Quick Run:${RESET}"
    echo -e "${PINK}    ./run_typhon.sh${RESET}\n"
    echo -e "${YELLOW}  Method 2 - Manual Activation:${RESET}"
    echo -e "${PINK}    source athex/bin/activate${RESET}"
    echo -e "${PINK}    python3 main.py${RESET}\n"
    echo -e "${YELLOW}  Method 3 - Using Helper Script:${RESET}"
    echo -e "${PINK}    ./activate_athex.sh${RESET}"
    echo -e "${PINK}    python3 main.py${RESET}\n"
    
    echo -e "${ORANGE}📌 Important Notes:${RESET}"
    echo -e "${CYAN}  • To deactivate environment: ${PINK}deactivate${RESET}"
    echo -e "${CYAN}  • Virtual environment location: ${PINK}$(pwd)/athex${RESET}"
    echo -e "${CYAN}  • For updates, run: ${PINK}./install.sh${RESET}\n"
    
    echo -e "${PINK}$(printf '═%.0s' {1..50})${RESET}"
    echo -e "${ORANGE}  Developed by ATHEX BLACK HAT${RESET}"
    echo -e "${BLUE}  Telegram: t.me/ServerKillers${RESET}"
    echo -e "${PINK}$(printf '═%.0s' {1..50})${RESET}\n"
}

# Error handling
handle_error() {
    echo -e "${RED}              ❌ INSTALLATION FAILED!              ${RESET}"
    echo -e "${YELLOW}Please check the errors above and try again.${RESET}"
    echo -e "${CYAN}For support: t.me/ServerKillers${RESET}\n"
    exit 1
}

# Main installation flow
main() {
    # Trap errors
    trap 'handle_error' ERR
    
    # Show banner
    show_banner
    
    # Check system
    check_system
    
    # Countdown
    echo -e "${CYAN}🚀 Preparing to start installation...${RESET}"
    countdown 3
    
    # Install virtualenv
    install_virtualenv
    
    # Setup virtual environment
    setup_virtualenv
    
    # Install requirements
    install_requirements
    
    # Create helper scripts
    create_helper
    
    # Show completion
    show_completion
    
    # Deactivate virtual environment
    if [[ "$VIRTUAL_ENV" != "" ]]; then
        deactivate
    fi
}

# Run main function
main

# Exit gracefully
exit 0