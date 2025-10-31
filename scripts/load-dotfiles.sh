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
# Format: "destination_path:source_path_in_repo"
# If no colon is present, it uses the same path relative to HOME and REPO_DIR
DOTFILES=(
  ".zshrc"
  ".tmux.conf"
  ".vimrc"
  ".gitconfig"
  ".gitignore_global"
  ".config/ghostty/config:ghostty-config"
  "${HOME}/Library/Application Support/Code/User/settings.json:vscode/settings.json"
  "${HOME}/Library/Application Support/Code/User/keybindings.json:vscode/keybindings.json"
  "${HOME}/Library/Application Support/Code/User/mcp.json:vscode/mcp.json"
  "${HOME}/Library/Application Support/Code/User/snippets:vscode/snippets"
  ".config/iterm2/com.googlecode.iterm2.plist:iterm2/com.googlecode.iterm2.plist"
)

# Function to get source and destination paths
get_paths() {
  local entry="$1"
  if [[ "$entry" == *":"* ]]; then
    # Split on colon
    local dest_path="${entry%:*}"
    local source_path="${entry#*:}"
  else
    # Use same path for both
    local dest_path="$entry"
    local source_path="$entry"
  fi

  # Default to HOME if destination doesn't start with /
  if [[ "$dest_path" != /* ]]; then
    dest_path="$HOME/$dest_path"
  fi

  echo "$REPO_DIR/$source_path:$dest_path"
}

# Copy each dotfile from repository to destination
for dotfile_entry in "${DOTFILES[@]}"; do
  paths=$(get_paths "$dotfile_entry")
  source_path="${paths%:*}"
  dest_path="${paths#*:}"

  if [ -f "$source_path" ] || [ -d "$source_path" ]; then
    # Create destination directory if it doesn't exist
    dest_dir="$(dirname "$dest_path")"
    mkdir -p "$dest_dir"

    echo "Loading $source_path to $dest_path"
    cp -r "$source_path" "$dest_path"
  else
    echo "Warning: $source_path does not exist in repository, skipping..."
  fi
done

echo "Done! Dotfiles have been loaded to your destination directories."
