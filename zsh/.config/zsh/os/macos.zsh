# macOS specific aliases and functions
alias sleep='pmset sleepnow'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
alias cleanup='find . -type f -name "*.DS_Store" -delete'

# Quick Look from terminal
alias ql='qlmanage -p 2>/dev/null'

# macOS specific folders
alias music="$HOME/Music"
alias pics="$HOME/Pictures"
alias apps="/Applications"

# Open applications
alias firefox='open -a Firefox'
alias chrome='open -a "Google Chrome"'
alias safari='open -a Safari'
alias vscode='open -a "Visual Studio Code"'
