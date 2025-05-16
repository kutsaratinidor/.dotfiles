#!/bin/bash

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo -e "${GREEN}🚀 Setting up your Debian environment...${NC}"

# Function to backup existing configs
backup_config() {
    local file="$1"
    if [ -e "$file" ] && [ ! -h "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -R "$file" "$BACKUP_DIR/"
        echo -e "${YELLOW}Backed up $file to $BACKUP_DIR/$(basename "$file")${NC}"
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to print status messages
status() {
    echo -e "${YELLOW}➡️  $1...${NC}"
}

# Function to print success messages
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error messages and exit
error() {
    echo -e "${RED}❌ Error: $1${NC}"
    exit 1
}

# Function to check command success
check_success() {
    if [ $? -ne 0 ]; then
        error "$1"
    fi
}

# Check if running on Debian/Ubuntu
if ! grep -q 'Debian\|Ubuntu' /etc/os-release 2>/dev/null; then
    error "This script is intended for Debian/Ubuntu systems only"
fi

# Check if running with sudo privileges
if ! command_exists sudo; then
    error "sudo is required to run this script"
fi

# Create backup of existing configs
backup_config "$HOME/.zshrc"
backup_config "$HOME/.config/nvim"
backup_config "$HOME/.config/zsh"
backup_config "$HOME/.tmux.conf"

# Update package lists
status "Updating package lists"
sudo apt update
sudo apt upgrade -y

# Install essential packages
status "Installing essential packages"
sudo apt install -y \
    curl \
    wget \
    git \
    stow \
    zsh \
    tmux \
    vim \
    xclip \
    python3 \
    python3-pip \
    fonts-powerline \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    ninja-build \
    gettext \
    cmake \
    unzip \
    ripgrep \
    fd-find

# Install Starship prompt
if ! command_exists starship; then
    status "Installing Starship prompt"
    curl -sS https://starship.rs/install.sh | sh
    success "Starship installed"
fi

# Install pyenv
if ! command_exists pyenv; then
    status "Installing pyenv"
    curl https://pyenv.run | bash
    success "pyenv installed"
fi

# Install LSD (LSDeluxe)
if ! command_exists lsd; then
    status "Installing LSD"
    TEMP_DEB="$(mktemp)" &&
    wget -O "$TEMP_DEB" "https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd_1.0.0_amd64.deb" &&
    sudo dpkg -i "$TEMP_DEB"
    rm -f "$TEMP_DEB"
    success "LSD installed"
fi

# Install WezTerm
if ! command_exists wezterm; then
    status "Installing WezTerm"
    TEMP_DEB="$(mktemp)" &&
    wget -O "$TEMP_DEB" "https://github.com/wez/wezterm/releases/latest/download/wezterm-debian12.deb" &&
    sudo dpkg -i "$TEMP_DEB"
    rm -f "$TEMP_DEB"
    success "WezTerm installed"
fi

# Install Nerd Font
status "Installing MesloLGS Nerd Font"
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && \
    curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Meslo/M/Regular/MesloLGSNerdFontMono-Regular.ttf
fc-cache -f -v
success "Font installed"

# Install Neovim from source
if ! command_exists nvim; then
    status "Installing Neovim from source"
    cd "$(mktemp -d)"
    git clone https://github.com/neovim/neovim
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
    success "Neovim installed"

    # Install language servers and tools for LSP
    status "Installing LSP servers and tools"
    # Install node and npm
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt install -y nodejs
    
    # Install common language servers
    sudo npm install -g \
        typescript \
        typescript-language-server \
        pyright \
        bash-language-server \
        vscode-langservers-extracted \
        @tailwindcss/language-server

    # Install formatters and linters
    sudo npm install -g \
        prettier \
        eslint
    
    pip3 install --user \
        black \
        ruff \
        mypy

    success "Language servers and tools installed"
fi

# Set up dotfiles
status "Setting up dotfiles"
if [ ! -d "$HOME/.dotfiles" ]; then
    git clone https://github.com/yourusername/dotfiles.git "$HOME/.dotfiles"
fi

cd "$HOME/.dotfiles"

# Function to safely stow configurations
safe_stow() {
    local config=$1
    status "Stowing $config configuration"
    if [ -d "$config" ]; then
        stow --restow "$config" 2>/dev/null || {
            echo -e "${YELLOW}⚠️  Conflict with existing $config configuration${NC}"
            read -p "$(echo -e ${YELLOW}Do you want to override? [y/N]: ${NC})" -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                stow --adopt "$config"
                success "$config configuration stowed"
            else
                echo -e "${YELLOW}Skipping $config configuration${NC}"
            fi
        }
    else
        echo -e "${YELLOW}⚠️  $config directory not found, skipping${NC}"
    fi
}

# Stow configurations
safe_stow zsh
safe_stow starship
safe_stow tmux
safe_stow vim
safe_stow wezterm
safe_stow git
safe_stow lsd
safe_stow nvim  # Neovim configuration

# Change default shell to zsh
if [[ $SHELL != *"zsh"* ]]; then
    status "Changing default shell to zsh"
    chsh -s "$(which zsh)"
    success "Shell changed to zsh"
fi

# Create necessary directories
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.zsh/plugins"

# Create .zshrc if it doesn't exist
if [ ! -f "$HOME/.zshrc" ] || [ -h "$HOME/.zshrc" ]; then
    status "Setting up .zshrc"
    # Remove existing symlink or file
    rm -f "$HOME/.zshrc"
    # Create parent directory if it doesn't exist
    mkdir -p "$HOME"
    # Link .zshrc
    ln -s "$HOME/.dotfiles/zsh/.zshrc" "$HOME/.zshrc"
    success ".zshrc configured"
fi

# Verify installations
status "Verifying installations"
errors=0
verify_installation() {
    if ! command_exists "$1"; then
        echo -e "${RED}❌ $1 not found${NC}"
        errors=$((errors + 1))
    else
        echo -e "${GREEN}✓ $1 installed${NC}"
    fi
}

verify_installation zsh
verify_installation nvim
verify_installation tmux
verify_installation starship
verify_installation lsd
verify_installation wezterm

# Show setup summary
echo -e "\n${GREEN}=== Setup Summary ===${NC}"
echo -e "Backup location: $BACKUP_DIR"
echo -e "Shell: $(which zsh)"
echo -e "Neovim version: $(nvim --version | head -n1)"
echo -e "Node version: $(node --version 2>/dev/null || echo 'Not installed')"
echo -e "Python version: $(python3 --version 2>/dev/null || echo 'Not installed')"

if [ $errors -gt 0 ]; then
    echo -e "\n${YELLOW}⚠️  Setup completed with $errors warnings. Please check the output above.${NC}"
else
    success "Setup complete! 🎉"
fi

# Final instructions
echo -e "\n${GREEN}=== Next Steps ===${NC}"
echo -e "1. Log out and log back in for all changes to take effect"
echo -e "2. Start a new terminal session to load zsh configurations"
echo -e "3. Run 'nvim' to trigger initial plugin installation"
echo -e "4. Check the README for additional configuration options"

if [ -d "$BACKUP_DIR" ]; then
    echo -e "\n${YELLOW}Note: Your original configurations were backed up to: $BACKUP_DIR${NC}"
fi
