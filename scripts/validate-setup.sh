#!/bin/bash

# Dotfiles Setup Validation Script
# Verifies installation and configuration integrity

set -euo pipefail

echo "🔍 Validating dotfiles setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Validation results
PASSED=0
FAILED=0
WARNINGS=0

# Helper functions
pass() {
    echo -e "✅ ${GREEN}PASS${NC}: $1"
    PASSED=$((PASSED + 1))
}

fail() {
    echo -e "❌ ${RED}FAIL${NC}: $1"
    FAILED=$((FAILED + 1))
}

warn() {
    echo -e "⚠️  ${YELLOW}WARN${NC}: $1"
    WARNINGS=$((WARNINGS + 1))
}

# Validation checks
echo "🖥️  System Validation"
echo "==================="

# Check macOS
if [ "$(uname -s)" = "Darwin" ]; then
    pass "Running on macOS $(sw_vers -productVersion)"
else
    fail "Not running on macOS"
fi

# Check required environment variables
echo -e "\n🔧 Environment Variables"
echo "========================"

if [ -n "${XDG_CONFIG_HOME:-}" ]; then
    pass "XDG_CONFIG_HOME is set: $XDG_CONFIG_HOME"
else
    fail "XDG_CONFIG_HOME is not set"
fi

if [ -n "${DOTFILES:-}" ]; then
    pass "DOTFILES is set: $DOTFILES"
else
    fail "DOTFILES is not set"
fi

if [ -n "${ZDOTDIR:-}" ]; then
    pass "ZDOTDIR is set: $ZDOTDIR"
else
    warn "ZDOTDIR is not set"
fi

# Check essential tools
echo -e "\n🛠️  Essential Tools"
echo "=================="

tools=("brew" "git" "nvim" "zsh" "curl")
for tool in "${tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
        pass "$tool is installed: $(which "$tool")"
    else
        fail "$tool is not installed or not in PATH"
    fi
done

# Check script permissions
echo -e "\n📋 Script Permissions"
echo "====================="

scripts=(".install" "run.sh" ".symlinks" ".macos" ".install_lsps")
for script in "${scripts[@]}"; do
    if [ -f "$script" ]; then
        if [ -x "$script" ]; then
            pass "$script has execute permission"
        else
            warn "$script is not executable"
        fi
    else
        fail "$script not found"
    fi
done

# Check symlink integrity
echo -e "\n🔗 Symlink Validation"
echo "====================="

if [ -d "$XDG_CONFIG_HOME" ]; then
    pass "Config directory exists: $XDG_CONFIG_HOME"
    
    # Check some key symlinks
    key_configs=("nvim" "zsh" "git")
    for config in "${key_configs[@]}"; do
        config_path="$XDG_CONFIG_HOME/$config"
        if [ -L "$config_path" ]; then
            if [ -e "$config_path" ]; then
                pass "$config symlink is valid"
            else
                fail "$config symlink is broken"
            fi
        else
            warn "$config is not a symlink (might be copied)"
        fi
    done
else
    fail "Config directory does not exist: $XDG_CONFIG_HOME"
fi

# Check Neovim configuration
echo -e "\n⚡ Neovim Configuration"
echo "======================="

if command -v nvim >/dev/null 2>&1; then
    if [ -f "$XDG_CONFIG_HOME/nvim/init.lua" ]; then
        pass "Neovim init.lua exists"
        
        # Test Neovim configuration syntax
        if nvim --headless -c 'lua vim.print("Config OK")' -c 'quit' >/dev/null 2>&1; then
            pass "Neovim configuration syntax is valid"
        else
            fail "Neovim configuration has syntax errors"
        fi
    else
        fail "Neovim init.lua not found"
    fi
else
    warn "Neovim not installed, skipping config check"
fi

# Security checks
echo -e "\n🛡️  Security Validation"
echo "======================="

# Check for common sensitive files
sensitive_patterns=("*.key" "*.pem" "*password*" "*secret*" "*.env")
found_sensitive=false

for pattern in "${sensitive_patterns[@]}"; do
    if find . -name "$pattern" -type f 2>/dev/null | grep -q .; then
        warn "Found potentially sensitive files matching: $pattern"
        found_sensitive=true
    fi
done

if [ "$found_sensitive" = false ]; then
    pass "No obvious sensitive files found"
fi

# Check git status for uncommitted sensitive files
if git status --porcelain 2>/dev/null | grep -q .; then
    warn "Uncommitted changes detected - review before committing"
else
    pass "No uncommitted changes"
fi

# Summary
echo -e "\n📊 Validation Summary"
echo "===================="
echo -e "✅ Passed: ${GREEN}$PASSED${NC}"
echo -e "❌ Failed: ${RED}$FAILED${NC}"  
echo -e "⚠️  Warnings: ${YELLOW}$WARNINGS${NC}"

if [ $FAILED -eq 0 ]; then
    echo -e "\n🎉 ${GREEN}All critical validations passed!${NC}"
    exit 0
else
    echo -e "\n💥 ${RED}Some validations failed. Please fix the issues above.${NC}"
    exit 1
fi