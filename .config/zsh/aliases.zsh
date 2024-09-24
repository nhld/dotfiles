alias c='clear'
alias ..='cd ..'
alias dl='cd $HOME/Downloads'
alias dt='cd $HOME/Desktop'
alias brewu='brew update && brew upgrade && brew cleanup'
alias brewuc='brew upgrade --cask $(brew list --cask)'
alias brewf='brew bundle dump --force --file=$HOME/dotfiles/.brewfile'
command -v eza >/dev/null 2>&1 && alias ls='eza --sort=extension --group-directories-first --icons --all'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'
command -v z >/dev/null 2>&1 && alias cd='z'
