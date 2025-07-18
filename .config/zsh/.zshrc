setopt hist_expire_dups_first
setopt SHARE_HISTORY
setopt hist_ignore_dups

# Avoid duplicates in zsh history
setopt HIST_IGNORE_ALL_DUPS # Ignore all duplicates (not just consecutive)
setopt HIST_SAVE_NO_DUPS    # Don't save duplicates to history file
HISTFILESIZE=1000000000

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"

export NOTES_DIR="$HOME/Documents/obsidian-vaults-local/notes"

eval "$(zoxide init zsh)"
source <(fzf --zsh)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(starship init zsh)"
# eval "$(rbenv init -)"
eval "$(rbenv init - zsh)"
eval "$(fnm env --use-on-cd)"
# eval "$(conda "shell.$(basename "${SHELL}")" hook)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"
export PATH="$HOME/.cargo/bin:$PATH"
