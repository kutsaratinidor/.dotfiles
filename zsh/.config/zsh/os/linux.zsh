# Linux specific aliases and functions
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias suspend='systemctl suspend'

# Update package managers
alias update='sudo apt update && sudo apt upgrade'
alias cleanup='sudo apt autoremove && sudo apt clean'

# System info
alias sysinfo='inxi -Fxz'
alias temp='sensors'

# Linux specific folders
alias docs="/usr/share/doc"
alias conf="/etc"
