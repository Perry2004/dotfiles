#!/bin/bash

# save-dotfiles.sh
# Script to save dotfiles from home directory to this repository

set -e # Exit on any error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "Saving dotfiles to repository..."
echo "Repository directory: $REPO_DIR"

# List of dotfiles to manage
DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
)

# Copy each dotfile from home directory to repository
for dotfile in "${DOTFILES[@]}"; do
  if [ -f "$HOME/$dotfile" ]; then
    echo "Copying $HOME/$dotfile to $REPO_DIR/$dotfile"
    cp "$HOME/$dotfile" "$REPO_DIR/$dotfile"
  else
    echo "Warning: $HOME/$dotfile does not exist, skipping..."
  fi
done

echo "Done! Dotfiles have been saved to the repository."

