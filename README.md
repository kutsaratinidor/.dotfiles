# 🏠 Dotfiles

My personal dotfiles for cross-platform development environment (macOS & Linux), managed with GNU Stow.

## ✨ Features

- 🐚 **Shell**: Zsh with custom aliases and syntax highlighting
- 🔥 **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/) with Nord color scheme
- ⌨️ **Keyboard**: Karabiner-Elements with custom mappings
  - Caps Lock as Ctrl/Esc
  - Tab as Hyper key when held
  - Custom application launching shortcuts
  - Window management shortcuts
- 📝 **Text Editor**: Vim configuration
- 🖥️ **Terminal Multiplexer**: Tmux with custom theme and plugins
- 🌟 **Prompt**: Starship with custom configuration
- 🎨 **Better ls**: LSD (LSDeluxe) for colorful file listings
- 🔄 **Git**: Global git configuration and aliases

## 📦 Dependencies

### macOS
```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install core dependencies
brew install \
  stow \
  zsh \
  starship \
  lsd \
  tmux \
  wezterm \
  pyenv \
  zsh-syntax-highlighting \
  zsh-autosuggestions

# macOS-specific tools
brew install \
  karabiner-elements \
  rectangle
```

### Linux (Debian/Ubuntu)

#### Automatic Installation
```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles

# Make the setup script executable
chmod +x ~/.dotfiles/scripts/setup_debian.sh

# Run the setup script
~/.dotfiles/scripts/setup_debian.sh
```

The setup script will:
- Install all required packages and dependencies
- Set up Starship prompt
- Install pyenv for Python version management
- Install LSD (LSDeluxe) for better ls output
- Install WezTerm terminal emulator
- Install MesloLGS Nerd Font
- Configure zsh as the default shell
- Set up all dotfiles using stow

#### Manual Installation
If you prefer to install components manually:
```bash
# Install core dependencies
sudo apt update && sudo apt install -y \
  stow \
  zsh \
  tmux \
  curl \
  git \
  python3 \
  python3-pip \
  zsh-syntax-highlighting \
  zsh-autosuggestions

# Additional tools can be installed following the script in
# ~/.dotfiles/scripts/setup_debian.sh
```

### Linux (Arch)
```bash
# Install dependencies
sudo pacman -S \
  stow \
  zsh \
  starship \
  lsd \
  tmux \
  wezterm \
  pyenv \
  zsh-syntax-highlighting \
  zsh-autosuggestions
```

## 🚀 Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Use Stow to symlink configurations:
```bash
# Stow individual configurations
stow git       # Git configuration
stow karabiner # Keyboard customization
stow lsd       # Modern ls replacement
stow starship  # Shell prompt
stow tmux      # Terminal multiplexer
stow vim       # Vim configuration
stow wezterm   # Terminal emulator
stow zsh       # Shell configuration

# Or stow everything at once
stow */
```

## 🔧 Configuration Details

### Zsh
- Custom aliases for git, navigation, and system commands
- Syntax highlighting and autosuggestions
- Integration with pyenv
- Smart OS detection with platform-specific features:
  - **macOS**: Native integrations with `pmset`, Finder, Quick Look
  - **Linux**: Integration with `xdg-open`, `xclip`, systemd
- Automatic plugin path detection for both platforms

### Karabiner-Elements
- Caps Lock → Ctrl (hold) / Esc (tap)
- Tab → Hyper key (hold) / Tab (tap)
- Quick application launching with Hyper + E
- Window management with Hyper + W
- German umlauts with Option + A/O/U

### Tmux
- Prefix key: Ctrl + Space
- Vi mode for navigation
- Custom theme with CPU and memory monitoring
- Session persistence with tmux-resurrect
- Split panes: \\ (horizontal), - (vertical)
- Vim-style pane navigation

### Git
- Multiple identity support (GitHub, Gitea)
- Global gitignore
- Useful aliases
- Default branch set to 'main'

### WezTerm
- Custom font (MesloLGS Nerd Font)
- Nord color scheme
- Borderless window
- Custom hyperlink rules

### Vim
- Modern defaults
- Custom keymaps
- Line numbers and relative numbers
- System clipboard integration
- File explorer configuration

## 🔄 Syncing to New Machine

1. Install dependencies:
```bash
# macOS
brew install stow

# Linux (Debian/Ubuntu)
sudo apt-get install stow

# Linux (Arch)
sudo pacman -S stow
```

2. Clone and apply:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow */
```

## 📝 Notes

### Platform-Specific Components

#### macOS Only
- Karabiner-Elements (keyboard customization)
- Rectangle (window management)

#### Linux Alternatives
- Window Management: Most desktop environments have built-in window management
- Keyboard Customization: Consider using xkb or kmonad

### Font Installation

#### macOS
```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

#### Linux
```bash
# Download MesloLGS NF from:
# https://github.com/ryanoasis/nerd-fonts/releases
mkdir -p ~/.local/share/fonts
# Copy downloaded fonts to ~/.local/share/fonts
fc-cache -fv
```

### General Notes
- Back up your existing dotfiles before installation
- Your zsh configuration will automatically detect the OS and load appropriate settings
- Some paths may need adjusting based on your Linux distribution
- Karabiner settings require manual approval in System Settings > Privacy & Security (macOS only)

## 📜 License

MIT License - Feel free to use and modify as you like.