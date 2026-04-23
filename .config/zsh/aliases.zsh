alias c='clear'
alias ..='cd ..'
alias dl='cd $HOME/Downloads'
alias dt='cd $HOME/Desktop'
alias brewu='brew update && brew upgrade && brew cleanup'
alias brewuc='brew upgrade --cask $(brew list --cask)'
alias brewf='brew bundle dump --force --file=$HOME/dotfiles/.brewfile'

# Git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gcm='git commit -m'
alias gco='git checkout'
alias gf='git fetch'
alias gl='git log'
alias glo='git log --oneline'
alias gm='git merge'
alias gp='git push'
alias gll='git pull'
alias gst='git status'
alias gbD='git branch | grep -v "^\*" | xargs git branch -D'
alias gbd='git branch | grep -v "^\*" | xargs git branch -d'
alias gs='git stash'
alias gsp='git stash pop'
alias grs='git fetch origin
git reset --soft origin/$(git branch --show-current)
'
alias grh='git fetch origin
git reset --hard origin/$(git branch --show-current)
'

command -v eza >/dev/null 2>&1 && alias ls='eza --sort=extension --group-directories-first --icons --all'
command -v lazygit >/dev/null 2>&1 && alias lg='lazygit' && alias lazygit="TERM=xterm-256color command lazygit"
command -v z >/dev/null 2>&1 && alias cd='z'
