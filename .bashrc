# XDG base directories.
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# Make sure this stuff is in the path.
export PATH="$HOME/.nvim/bin:$PATH"  # Neovim
export PATH="$HOME/.local/bin:$PATH" # Local scripts

# Use neovim as the default editor.
export EDITOR=nvim
export VISUAL=nvim

# Colorful sudo prompt.
SUDO_PROMPT="$(tput setaf 2 bold)Password: $(tput sgr0)" && export SUDO_PROMPT

# Man pages.
export MANPAGER='nvim +Man!'

# Ripgrep.
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"

# fzf setup.
export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#0e1419,hl:#e11299,fg+:#f8f8f2,bg+:#44475a,hl+:#e11299,info:#f1fa8c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#a4ffff,header:#6272a4 \
--cycle --pointer=▎ \
--marker=▎ \
--bind=alt-s:toggle"

# If not running interactively, stop here.
[[ $- != *i* ]] && return
