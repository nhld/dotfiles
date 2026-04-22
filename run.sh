#!/bin/zsh

# Dotfiles Master Installation Script
# Exit on error, undefined variables, and pipe failures
set -euo pipefail

# Enable logging
LOG_FILE="$HOME/dotfiles-setup.log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1

echo "=================================="
echo "🚀 Dotfiles Setup Started: $(date)"
echo "Log file: $LOG_FILE"
echo "=================================="

# Parse flags and component argument
DRY_RUN=false
COMPONENT="all"

for arg in "$@"; do
    case "$arg" in
        --dry-run)
            DRY_RUN=true
            ;;
        all|macos|homebrew|install|symlinks|links)
            COMPONENT="$arg"
            ;;
        -h|--help)
            echo "Usage: $0 [all|macos|homebrew|symlinks] [--dry-run]"
            exit 0
            ;;
        *)
            echo "❌ Error: Unknown argument '$arg'"
            echo "Usage: $0 [all|macos|homebrew|symlinks] [--dry-run]"
            exit 1
            ;;
    esac
done

if [ "$DRY_RUN" = true ]; then
    echo "🔍 Running in dry-run mode"
fi

# Validation function
validate_environment() {
    echo "🔍 Validating environment..."
    
    if [ "$(uname -s)" != "Darwin" ]; then
        echo "❌ Error: This setup is designed for macOS"
        exit 1
    fi
    
    if [ -z "${HOME:-}" ]; then
        echo "❌ Error: HOME environment variable not set"
        exit 1
    fi
    
    echo "✅ Environment validation passed"
}

# Component functions
run_macos_setup() {
    echo "🖥️  Setting macOS defaults..."
    if [ -f "./.macos" ]; then
        if [ "$DRY_RUN" = true ]; then
            echo "🔍 Would run: ./.macos"
        else
            ./.macos
        fi
    else
        echo "⚠️  Warning: .macos file not found, skipping"
    fi
}

run_homebrew_install() {
    echo "🍺 Installing Homebrew and packages..."
    if [ -f "./.install" ]; then
        if [ "$DRY_RUN" = true ]; then
            echo "🔍 Would run: ./.install"
        else
            ./.install
        fi
    else
        echo "⚠️  Warning: .install file not found, skipping"
    fi
}

run_symlink_creation() {
    echo "🔗 Creating configuration symlinks..."

    if [ -f "./.symlinks" ]; then
        if [ "$DRY_RUN" = true ]; then
            ./.symlinks --dry-run
        else
            ./.symlinks
        fi
    else
        echo "⚠️  Warning: .symlinks file not found, skipping"
    fi
}

# Main execution
validate_environment

case "$COMPONENT" in
    "macos")
        run_macos_setup
        ;;
    "homebrew"|"install")
        run_homebrew_install
        ;;
    "symlinks"|"links")
        run_symlink_creation
        ;;
    "all")
        run_macos_setup
        run_homebrew_install
        run_symlink_creation
        ;;
esac

echo "=================================="
echo "✅ Dotfiles Setup Completed: $(date)"
echo "=================================="
