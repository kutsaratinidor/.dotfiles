# --------------------------------------
# 🌍 OS Detection and Configuration
# --------------------------------------
case "$OSTYPE" in
  darwin*) 
    export OS="macos"
    [[ -f "$HOME/.config/zsh/os/macos.zsh" ]] && source "$HOME/.config/zsh/os/macos.zsh"
    ;;
  linux-gnu*) 
    export OS="linux"
    [[ -f "$HOME/.config/zsh/os/linux.zsh" ]] && source "$HOME/.config/zsh/os/linux.zsh"
    ;;
  *) export OS="unknown" ;;
esac

# --------------------------------------
# 🍺 Homebrew Setup (Optional)
# --------------------------------------
if command -v brew &>/dev/null; then
  eval "$($(command -v brew) shellenv)"
fi

# --------------------------------------
# 🚀 Starship Prompt
# --------------------------------------
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

# --------------------------------------
# 🌈 Syntax Highlighting
# --------------------------------------
syntax_highlighting_paths=(
  # Homebrew (macOS)
  "$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  # Common Linux paths
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"  # Arch
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"              # Ubuntu/Debian
  # Manual installation
  "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for path in "${syntax_highlighting_paths[@]}"; do
  if [[ -f "$path" ]]; then
    source "$path"
    break
  fi
done

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# --------------------------------------
# 💡 Autosuggestions
# --------------------------------------
autosuggestions_paths=(
  # Homebrew (macOS)
  "$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # Common Linux paths
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"      # Arch
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"                  # Ubuntu/Debian
  # Manual installation
  "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
)

for path in "${autosuggestions_paths[@]}"; do
  if [[ -f "$path" ]]; then
    source "$path"
    break
  fi
done

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


