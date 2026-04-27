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
  "${HOME}/Library/Application Support/Code/User/settings.json:vscode/settings.json"
  "${HOME}/Library/Application Support/Code/User/keybindings.json:vscode/keybindings.json"
  "${HOME}/Library/Application Support/Code/User/mcp.json:vscode/mcp.json"
  "${HOME}/Library/Application Support/Code/User/snippets:vscode/snippets"
  ".config/iterm2/com.googlecode.iterm2.plist:iterm2/com.googlecode.iterm2.plist"
  ".yabairc"
  ".skhdrc"
  ".config/yazi/yazi.toml"
  "${HOME}/Library/Application Support/k9s/config.yaml:k9s/config.yaml"
  "${HOME}/Library/Application Support/k9s/skins/skin.yaml:k9s/skins/skin.yaml"
)

LINK_DOTFILES=(
  ".config/nvim"
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

copy_path() {
  local source_path="$1"
  local dest_path="$2"

  mkdir -p "$(dirname "$dest_path")"

  if [ -d "$source_path" ]; then
    mkdir -p "$dest_path"
    rsync -a --delete "$source_path/" "$dest_path/"
  else
    cp "$source_path" "$dest_path"
  fi
}

ensure_link() {
  local source_path="$1"
  local dest_path="$2"

  if [ -L "$dest_path" ] && [ "$(readlink "$dest_path")" = "$source_path" ]; then
    echo "Already linked $dest_path to $source_path"
    return
  fi

  if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
    echo "Removing existing $dest_path"
    rm -rf "$dest_path"
  fi

  mkdir -p "$(dirname "$dest_path")"
  echo "Linking $source_path to $dest_path"
  ln -s "$source_path" "$dest_path"
}

# Copy each dotfile from source to repository
for dotfile_entry in "${DOTFILES[@]}"; do
  paths=$(get_paths "$dotfile_entry")
  source_path="${paths%:*}"
  dest_path="${paths#*:}"

  if [ -f "$source_path" ] || [ -d "$source_path" ]; then
    echo "Copying $source_path to $dest_path"
    copy_path "$source_path" "$dest_path"
  else
    echo "Warning: $source_path does not exist, skipping..."
  fi
done

for link_entry in "${LINK_DOTFILES[@]}"; do
  source_path="$HOME/$link_entry"
  dest_path="$REPO_DIR/$link_entry"

  if [ ! -L "$source_path" ] || [ "$(readlink "$source_path")" != "$dest_path" ]; then
    if [ -e "$source_path" ]; then
      echo "Copying $source_path to $dest_path"
      mkdir -p "$dest_path"
      rsync -a --delete --exclude='.git' --exclude='.DS_Store' "$source_path/" "$dest_path/"
    elif [ ! -e "$dest_path" ]; then
      echo "Warning: $source_path does not exist, skipping..."
      continue
    fi
  fi

  ensure_link "$dest_path" "$source_path"
done

echo "Done! Dotfiles have been saved to the repository."
