alias c clear

if type -q nvim
    alias vi nvim
    alias nv nvim
    alias vim nvim
    alias nn "nvim $NOTES_DIR/$(date +"%Y%m%d%H%M.md")"
end

alias g git
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
alias rr "rm -rf"
alias sf "source $XDG_CONFIG_HOME/fish/config.fish"

if type -q z
    alias dl 'z $HOME/Downloads'
    alias dt 'z $HOME/Desktop'
end

if type -q lazygit
    alias lg lazygit
end

if type -q lazydocker
    alias lzd lazydocker
end

if type -q eza
    alias ls "eza --sort=extension --group-directories-first"
    alias ll "ls -l --icons --total-size --no-user -o"
    alias lla "ll -a"
    alias llt "ll --tree --level=2 -a"
    alias lld "ll -D"
    alias llf "ll -f"
end
