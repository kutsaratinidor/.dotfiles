# 🏠 Dotfiles

My personal dotfiles for macOS development environment, managed with GNU Stow.

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

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install GNU Stow
brew install stow

# Core dependencies
brew install \
  zsh \
  starship \
  lsd \
  tmux \
  karabiner-elements \
  wezterm \
  rectangle \
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
- OS-specific configurations

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

- Back up your existing dotfiles before installation
- Some configurations might need adjusting based on your system
- Karabiner settings require manual approval in System Settings > Privacy & Security
- WezTerm and Rectangle configurations assume macOS

## 📜 License

MIT License - Feel free to use and modify as you like.