# Do nothing if not in interactive shell
if not status is-interactive
    return 0
end

fish_vi_key_bindings
set -U fish_greeting

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

if type -q fnm
    fnm env --use-on-cd | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q starship
    starship init fish | source
end

if type -q fzf
    fzf --fish | source
end

source $XDG_CONFIG_HOME/fish/aliases.fish
source "$HOME/.cargo/env.fish"
