#!/bin/bash

# load-dotfiles.sh
# Script to load dotfiles from this repository to home directory

set -e # Exit on any error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

echo "Loading dotfiles from repository..."
echo "Repository directory: $REPO_DIR"

# List of dotfiles to manage
DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
)

# Copy each dotfile from repository to home directory
for dotfile in "${DOTFILES[@]}"; do
  if [ -f "$REPO_DIR/$dotfile" ]; then
    echo "Loading $dotfile to $HOME/$dotfile"
    cp "$REPO_DIR/$dotfile" "$HOME/$dotfile"
  else
    echo "Warning: $REPO_DIR/$dotfile does not exist in repository, skipping..."
  fi
done

echo "Done! Dotfiles have been loaded to your home directory."
