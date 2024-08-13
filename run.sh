#!/bin/zsh

# Set macos defaults
[ -f "./.macos" ] && ./.macos

# Install Homebrew, Formulae, Casks
[ -f "./.install" ] && ./.install

# Move old configs if any exists
[ -d "$XDG_CONFIG_HOME" ] && mv "$XDG_CONFIG_HOME" "$HOME/temp_config"

# Create symlinks for new config
[ -f "./.symlinks" ] && ./.symlinks
