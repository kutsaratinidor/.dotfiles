# --------------------------------------
# 🌍 OS Detection
# --------------------------------------
case "$OSTYPE" in
  darwin*) export OS="macos" ;;
  linux-gnu*) export OS="linux" ;;
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
if [[ -f "$(brew --prefix 2>/dev/null)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -f "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# --------------------------------------
# 💡 Autosuggestions
# --------------------------------------
if [[ -f "$(brew --prefix 2>/dev/null)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
elif [[ -f "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$HOME/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


