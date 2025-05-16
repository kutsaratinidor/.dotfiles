#!/bin/bash

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}🧹 Uninstalling dotfiles and configurations...${NC}"

# Function to print status messages
status() {
    echo -e "${YELLOW}➡️  $1...${NC}"
}

# Function to print success messages
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ask for confirmation
read -p "$(echo -e ${RED}This will remove configurations and installed packages. Are you sure? [y/N]: ${NC})" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}Uninstall cancelled.${NC}"
    exit 1
fi

# Remove dotfiles symlinks
status "Removing dotfile symlinks"
cd "$HOME/.dotfiles"
stow -D zsh
stow -D starship
stow -D tmux
stow -D vim
stow -D wezterm
stow -D git
stow -D lsd
stow -D nvim
success "Dotfile symlinks removed"

# Restore original shell if it was changed
if [[ $SHELL == *"zsh"* ]]; then
    status "Restoring default shell to bash"
    chsh -s "$(which bash)"
    success "Shell restored to bash"
fi

# Remove installed packages
status "Removing installed packages"
sudo apt remove -y \
    zsh \
    tmux \
    vim \
    xclip \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    ninja-build \
    gettext \
    cmake \
    unzip \
    ripgrep \
    fd-find

# Remove Neovim if installed from source
if command_exists nvim; then
    status "Removing Neovim"
    sudo rm -f /usr/local/bin/nvim
    sudo rm -rf /usr/local/share/nvim/
    success "Neovim removed"
fi

# Remove Starship prompt
if command_exists starship; then
    status "Removing Starship prompt"
    sh -c "yes | sh -c '$(curl -fsSL https://starship.rs/install.sh)' -- --uninstall"
    success "Starship removed"
fi

# Remove LSD
if command_exists lsd; then
    status "Removing LSD"
    sudo apt remove -y lsd
    success "LSD removed"
fi

# Remove WezTerm
if command_exists wezterm; then
    status "Removing WezTerm"
    sudo apt remove -y wezterm
    success "WezTerm removed"
fi

# Remove pyenv
if [ -d "$HOME/.pyenv" ]; then
    status "Removing pyenv"
    rm -rf "$HOME/.pyenv"
    success "pyenv removed"
fi

# Remove Node.js and npm packages
if command_exists node; then
    status "Removing Node.js and global npm packages"
    sudo apt remove -y nodejs
    rm -rf "$HOME/.npm"
    success "Node.js removed"
fi

# Remove fonts
status "Removing installed fonts"
rm -f "$HOME/.local/share/fonts/MesloLGSNerdFontMono-Regular.ttf"
fc-cache -f -v
success "Fonts removed"

# Remove config directories
status "Removing configuration directories"
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.config/starship"
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.local/share/nvim"
rm -rf "$HOME/.local/state/nvim"
rm -rf "$HOME/.cache/nvim"
rm -rf "$HOME/.zsh"

# Remove .zshrc if it's our symlink
if [ -h "$HOME/.zshrc" ]; then
    status "Removing .zshrc symlink"
    rm -f "$HOME/.zshrc"
    # Optionally create a basic .zshrc
    echo "# Basic .zshrc created after uninstalling dotfiles" > "$HOME/.zshrc"
    success ".zshrc removed and basic version created"
fi
success "Configuration directories removed"

# Cleanup packages
status "Cleaning up package manager"
sudo apt autoremove -y
sudo apt clean
success "Package cleanup complete"

echo -e "${GREEN}🎉 Uninstallation complete!${NC}"
echo -e "${YELLOW}Note: The dotfiles repository at ~/.dotfiles has not been removed.${NC}"
echo -e "${YELLOW}You can remove it manually with: rm -rf ~/.dotfiles${NC}"
echo -e "${YELLOW}Please log out and log back in for all changes to take effect.${NC}"
