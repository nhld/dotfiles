if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Activate vim key bindings
fish_vi_key_bindings

# Use <j><k> to <Esc>
bind --mode insert --sets-mode default jk repaint

# Aliases
alias c clear
alias vi nvim
alias vim nvim

# Eza kinda better ls 
if type -q eza
    alias ll "eza -l --icons --total-size --no-user -o"
    alias lla "ll -a"
    alias llt "ll --tree --level=2 -a"
    alias lld "ll -D"
    alias llf "ll -f"
end

# bobthefish theme stuff
set theme_color_scheme gruvbox
set -g theme_nerd_fonts yes
set -g theme_display_git yes
set -g theme_display_git_default_branch yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_vi yes
set -g theme_display_user yes
