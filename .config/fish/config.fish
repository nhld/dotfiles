# do nothing if not in interactive shell
if not status is-interactive
  return 0
end

# activate vim key bindings
fish_vi_key_bindings

# remove the greeting message
set -U fish_greeting

alias c clear
alias vi nvim
alias vim nvim
alias nv nvim

alias nvks 'NVIM_APPNAME="nvim-kickstart" nvim'

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

alias lg "lazygit"

if type -q eza
  alias ll "eza -l --icons --total-size --no-user -o"
  alias lla "ll -a"
  alias llt "ll --tree --level=2 -a"
  alias lld "ll -D"
  alias llf "ll -f"
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# cargo path
# set PATH $HOME/.cargo/bin $PATH
#fish_add_path $HOME/.cargo/bin

zoxide init fish | source
