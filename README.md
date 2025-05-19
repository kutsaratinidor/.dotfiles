# Dotfiles

My personal dotfiles for macOS development environment, managed with GNU Stow.

This was inspired by videos made by [Hendrik](https://github.com/hendrikmi) on his Youtube channel [Henry Misc](https://github.com/hendrikmi)

## Features

- **Shell**: Zsh with custom aliases and syntax highlighting
- **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/) with Nord color scheme
- **Keyboard**: Karabiner-Elements with custom mappings
  - Caps Lock as Ctrl/Esc
  - Tab as Hyper key when held
  - Custom application launching shortcuts
  - Window management shortcuts via Rectangle
- **Text Editor**: Vim and Neovim configuration
- **Terminal Multiplexer**: Tmux with custom theme and plugins
- **Prompt**: Starship with custom configuration
- **Utils**: LSD for better ls output, custom git aliases

## Dependencies

First, install Homebrew:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install the required packages:
```bash
# Core utilities
brew install stow zsh starship lsd tmux pyenv

# Shell enhancements
brew install zsh-syntax-highlighting zsh-autosuggestions

# macOS applications
brew install --cask wezterm karabiner-elements rectangle

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/kutsaratinidor/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install dependencies (if you haven't already):
```bash
brew bundle  # This will install all dependencies from the Brewfile
```

3. Set up configurations:
```bash
# Set up all configurations
stow */

# Or set up individual configurations
stow git       # Git configuration
stow karabiner # Keyboard customization
stow lsd      # Modern ls replacement
stow starship # Shell prompt
stow tmux     # Terminal multiplexer
stow vim      # Vim configuration
stow nvim     # Neovim configuration
stow wezterm  # Terminal emulator
stow zsh      # Shell configuration
```

4. Change your shell to zsh:
```bash
chsh -s $(which zsh)
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

## Notes

- Back up your existing configuration files before installation
- Karabiner-Elements requires manual approval in System Settings > Privacy & Security
- Some applications may need to be restarted after configuration changes
- Make sure to install the MesloLGS Nerd Font for proper icon display in WezTerm

## License

MIT License - Feel free to use and modify as you like.
