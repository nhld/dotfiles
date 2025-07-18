# XDG locations.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Make sure this stuff is in the path.
# export PATH="$HOME/nvim/bin:$PATH" # neovim
export PATH="$HOME/Applications/WezTerm.app/Contents/MacOS:$PATH" # Wezterm.
export PATH="$HOME/.local/bin:$PATH"                              # Local scripts.

# Load nvm.
export NVM_DIR="$XDG_CONFIG_HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# zsh configuration.
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set up neovim as the default editor.
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Disable Apple's save/restore mechanism.
export SHELL_SESSIONS_DISABLE=1

export RIPGREP_CONFIG_PATH="$HOME/dotfiles/.config/.ripgreprc"
export STARSHIP_CONFIG="$HOME/dotfiles/.config/.starship.toml"

export DOTFILES="$HOME/dotfiles/.config"
