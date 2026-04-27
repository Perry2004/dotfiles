# dotfiles

## Dotfiles
``` sh
├── .config
│   └── yazi
│       └── yazi.toml
├── .gitconfig
├── .gitignore_global # Global Git ignore rules.
├── .skhdrc # skhd hotkeys for yabai.
├── .tmux.conf # tmux configs, tpm plugins, theme, session restore and keybindings.
├── .vimrc # Minimal sane default Vim config.
├── .yabairc # yabai layout and opacity settings.
├── .zshrc # zsh configuration with oh-my-zsh.
├── README.md
├── ghostty-config # Ghostty terminal settings with tmux integration.
├── iterm2
│   └── com.googlecode.iterm2.plist # iterm2 config backup
├── k9s
│   ├── config.yaml
│   └── skins
│       └── skin.yaml # Rose Pine k9s color theme.
├── scripts
│   ├── load-dotfiles.sh
│   └── save-dotfiles.sh
└── vscode
    ├── keybindings.json # VSCode keybindings inspired by LazyVim.
    ├── mcp.json
    ├── settings.json
    └── snippets
```
## Scripts
- `scripts/load-dotfiles.sh`: Restores the repo's dotfiles into the expected macOS locations under `$HOME` and app support folders.
- `scripts/save-dotfiles.sh`: Captures the current machine's matching dotfiles and app configs into this repository.
