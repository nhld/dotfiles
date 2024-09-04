alias c='clear'
alias ..='cd ..'
alias dl='cd $HOME/Downloads'
alias dt='cd $HOME/Desktop'
alias brewu='brew update && brew upgrade && brew cleanup'
alias brewuc='brew upgrade --cask $(brew list --cask)'
command -v eza >/dev/null 2>&1 && alias ls='eza --sort=extension --group-directories-first'
