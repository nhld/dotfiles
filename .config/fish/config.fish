# Do nothing if not in interactive shell
if not status is-interactive
    return 0
end

fish_vi_key_bindings
set -U fish_greeting

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

source $XDG_CONFIG_HOME/fish/aliases.fish

zoxide init fish | source
starship init fish | source
fzf --fish | source
