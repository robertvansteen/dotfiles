#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Homebrew installed."
else
  echo "Homebrew already installed."
fi

# --- Brew packages ---
echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/brewfile/Brewfile"

# --- Stow dotfiles ---
echo "Linking dotfiles with stow..."
cd "$DOTFILES_DIR"
stow --restow .

# --- Claude panes directory ---
mkdir -p /tmp/claude-panes
echo "Ensured /tmp/claude-panes/ exists."

# --- TPM (tmux plugin manager) ---
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  echo "TPM installed."
else
  echo "TPM already installed."
fi

# --- Summary ---
echo ""
echo "Setup complete:"
echo "  - Homebrew: ready"
echo "  - Brew packages: installed"
echo "  - Dotfiles: linked"
echo "  - /tmp/claude-panes/: created"
echo "  - TPM: ready (prefix + I inside tmux to install plugins)"
