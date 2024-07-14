alias c "clear"

if type -q nvim
  alias vi "nvim"
  alias nv "nvim"
  alias vim "nvim"
end

alias g 'git'
alias ga 'git add'
alias gb 'git branch'
alias gc 'git commit --verbose'
alias gcm 'git commit -m'
alias gco 'git checkout'
alias gf 'git fetch'
alias gl 'git log'
alias gm 'git merge'
alias gp 'git push'
alias gst 'git status'

alias .. 'cd ..'
alias dl 'cd $HOME/Downloads'

alias nn 'nvim $NOTES_DIR/$(date +"%Y%m%d%H%M.md")'
alias sf "source $XDG_CONFIG_HOME/fish/config.fish"

if type -q lazygit
  alias lg "lazygit"
end

if type -q eza
  alias ll "eza -l --icons --total-size --no-user -o"
  alias lla "ll -a"
  alias llt "ll --tree --level=2 -a"
  alias lld "ll -D"
  alias llf "ll -f"
end
