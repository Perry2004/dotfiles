# DotFiles

``` sh
.
├── .config
│   ├── nvim # Neovim/LazyVim config linked to ~/.config/nvim.
│   │   ├── .neoconf.json # neoconf workspace settings.
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   ├── lazyvim.json # LazyVim feature config.
│   │   ├── lua
│   │   │   ├── config
│   │   │   │   ├── autocmds.lua
│   │   │   │   ├── keymaps.lua
│   │   │   │   ├── lazy.lua
│   │   │   │   └── options.lua
│   │   │   └── plugins
│   │   │       ├── colorscheme.lua # Auto-switching Tokyonight colorscheme.
│   │   │       ├── copilot.lua # GitHub Copilot config.
│   │   │       ├── example.lua
│   │   │       ├── markdown.lua
│   │   │       ├── neo-tree.lua
│   │   │       ├── statuscol.lua
│   │   │       ├── toggleterm.lua
│   │   │       └── wakatime.lua
│   │   └── stylua.toml
│   └── yazi
│       └── yazi.toml # Yazi file manager config.
├── .gitconfig
├── .gitignore_global
├── .skhdrc # skhd hotkeys for yabai.
├── .tmux.conf # tmux configs, tpm plugins, theme, session restore and keybindings.
├── .vimrc # Minimal sane default Vim config.
├── .yabairc # yabai layout and opacity settings.
├── .zshrc # zsh configuration with oh-my-zsh.
├── README.md
├── ghostty-config # Ghostty terminal settings with tmux integration.
├── iterm2
│   └── com.googlecode.iterm2.plist # iTerm2 exported config backup.
├── k9s
│   ├── config.yaml
│   └── skins
│       └── skin.yaml # Rose Pine k9s color theme.
├── scripts
│   ├── load-dotfiles.sh # Load dotfiles and links.
│   └── save-dotfiles.sh # Save dotfiles and links.
└── vscode
    ├── keybindings.json # VSCode keybindings inspired by LazyVim.
    ├── mcp.json
    ├── settings.json
    └── snippets
```
## Scripts

- `scripts/load-dotfiles.sh`: Restores the repo's dotfiles into the expected macOS locations under `$HOME` and app support folders.
    - Nvim config is symlinked to `~/.config/nvim`.
    - Other dotfiles are copied to their respective locations.
- `scripts/save-dotfiles.sh`: Saves dotfiles into the repo
