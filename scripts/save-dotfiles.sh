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
# Format: "source_path:destination_path_in_repo"
# If no colon is present, it uses the same path relative to HOME and REPO_DIR
DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
  ".config/ghostty/config:ghostty-config"
  "${HOME}/Library/Application Support/Code/User/profiles/2b80b728/settings.json:vscode/settings.json"
  "${HOME}/Library/Application Support/Code/User/profiles/2b80b728/keybindings.json:vscode/keybindings.json"
  "${HOME}/Library/Application Support/Code/User/profiles/2b80b728/mcp.json:vscode/mcp.json"
  "${HOME}/Library/Application Support/Code/User/profiles/2b80b728/snippets:vscode/snippets"
)

# Function to get source and destination paths
get_paths() {
  local entry="$1"
  if [[ "$entry" == *":"* ]]; then
    # Split on colon
    local source_path="${entry%:*}"
    local dest_path="${entry#*:}"
  else
    # Use same path for both
    local source_path="$entry"
    local dest_path="$entry"
  fi
  
  # Default to HOME if source doesn't start with /
  if [[ "$source_path" != /* ]]; then
    source_path="$HOME/$source_path"
  fi
  
  echo "$source_path:$REPO_DIR/$dest_path"
}

# Copy each dotfile from source to repository
for dotfile_entry in "${DOTFILES[@]}"; do
  paths=$(get_paths "$dotfile_entry")
  source_path="${paths%:*}"
  dest_path="${paths#*:}"
  
  if [ -f "$source_path" ] || [ -d "$source_path" ]; then
    # Create destination directory if it doesn't exist
    dest_dir="$(dirname "$dest_path")"
    mkdir -p "$dest_dir"

    echo "Copying $source_path to $dest_path"
    cp -r "$source_path" "$dest_path"
  else
    echo "Warning: $source_path does not exist, skipping..."
  fi
done

echo "Done! Dotfiles have been saved to the repository."
