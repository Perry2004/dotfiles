#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$REPO_DIR/backups/$(date +%Y%m%d-%H%M%S)"
USED_BACKUP=0

# Format: "source_path_in_repo|destination_path"
# Relative destinations are resolved from $HOME.
LINKS=(
  ".zshrc|.zshrc"
  ".tmux.conf|.tmux.conf"
  ".vimrc|.vimrc"
  ".gitconfig|.gitconfig"
  ".gitignore_global|.gitignore_global"
  ".yabairc|.yabairc"
  ".skhdrc|.skhdrc"
  ".config/nvim|.config/nvim"
  ".config/yazi/yazi.toml|.config/yazi/yazi.toml"
  "ghostty-config|.config/ghostty/config"
  "iterm2/com.googlecode.iterm2.plist|Library/Application Support/iTerm2/com.googlecode.iterm2.plist"
  "vscode/settings.json|Library/Application Support/Code/User/settings.json"
  "vscode/keybindings.json|Library/Application Support/Code/User/keybindings.json"
  "vscode/mcp.json|Library/Application Support/Code/User/mcp.json"
  "vscode/chatLanguageModels.json|Library/Application Support/Code/User/chatLanguageModels.json"
  "k9s/config.yaml|Library/Application Support/k9s/config.yaml"
  "k9s/skins/skin.yaml|Library/Application Support/k9s/skins/skin.yaml"
)

remove_legacy_link() {
  local source_path="$1"
  local dest_path="$2"

  if [[ -L "$dest_path" && "$(readlink "$dest_path")" == "$source_path" ]]; then
    rm "$dest_path"
    echo "Removed legacy directory link $dest_path"
  fi
}

dest_path_for() {
  local dest="$1"

  if [[ "$dest" == /* ]]; then
    printf '%s\n' "$dest"
  else
    printf '%s\n' "$HOME/$dest"
  fi
}

backup_existing() {
  local dest_path="$1"
  local backup_path="$BACKUP_DIR/${dest_path#"$HOME"/}"

  if [[ "$dest_path" == "$REPO_DIR"* ]]; then
    echo "Refusing to back up repository path $dest_path"
    return 1
  fi

  mkdir -p "$(dirname "$backup_path")"
  mv "$dest_path" "$backup_path"
  USED_BACKUP=1
  echo "Backed up $dest_path to $backup_path"
}

link_path() {
  local source_path="$1"
  local dest_path="$2"

  if [[ ! -e "$source_path" ]]; then
    echo "Warning: $source_path does not exist in repository, skipping..."
    return
  fi

  if [[ -L "$dest_path" && "$(readlink "$dest_path")" == "$source_path" ]]; then
    echo "Already linked $dest_path"
    return
  fi

  if [[ -e "$dest_path" || -L "$dest_path" ]]; then
    backup_existing "$dest_path"
  fi

  mkdir -p "$(dirname "$dest_path")"
  ln -s "$source_path" "$dest_path"
  echo "Linked $dest_path -> $source_path"
}

echo "Setting up dotfile symlinks from $REPO_DIR"

remove_legacy_link "$REPO_DIR/vscode" "$(dest_path_for "Library/Application Support/Code/User")"
remove_legacy_link "$REPO_DIR/k9s" "$(dest_path_for "Library/Application Support/k9s")"

for entry in "${LINKS[@]}"; do
  IFS='|' read -r source_rel dest_rel <<< "$entry"
  link_path "$REPO_DIR/$source_rel" "$(dest_path_for "$dest_rel")"
done

if [[ "$USED_BACKUP" -eq 1 ]]; then
  echo "Existing files were backed up under $BACKUP_DIR"
fi

echo "Done."
