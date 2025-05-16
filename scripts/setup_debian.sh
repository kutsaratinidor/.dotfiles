#!/bin/bash

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Setting up your Debian environment...${NC}"

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

# Stow configurations
stow zsh
stow starship
stow tmux
stow vim
stow wezterm
stow git
stow lsd
stow nvim  # Neovim configuration

# Change default shell to zsh
if [[ $SHELL != *"zsh"* ]]; then
    status "Changing default shell to zsh"
    chsh -s "$(which zsh)"
    success "Shell changed to zsh"
fi

# Create necessary directories
mkdir -p "$HOME/.config/zsh"
mkdir -p "$HOME/.zsh/plugins"

success "Setup complete! 🎉"
echo -e "${GREEN}Please log out and log back in for all changes to take effect.${NC}"
echo -e "${YELLOW}Note: Some commands might need additional configuration. Check the README for details.${NC}"
