# zsh Options
# Increase history size
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Useful history settings
setopt HIST_IGNORE_DUPS     # Don't store duplicate commands
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks
setopt INC_APPEND_HISTORY   # Write commands to history immediately
setopt SHARE_HISTORY        # Share history across terminals



# Custom zsh
[ -f "$HOME/.config/zsh/custom.zsh" ] && source "$HOME/.config/zsh/custom.zsh"

# Aliases
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

# Created by `pipx` on 2025-04-21 16:53:55
export PATH="$PATH:/Users/spork/.local/bin"
