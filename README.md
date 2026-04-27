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
├── .gitignore
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
│   ├── archive
│   │   ├── load-dotfiles.sh # Legacy copy/load script.
│   │   └── save-dotfiles.sh # Legacy copy/save script.
│   └── setup-symlinks.sh # Link all managed dotfiles into their expected locations.
└── vscode
    ├── chatLanguageModels.json
    ├── keybindings.json # VSCode keybindings inspired by LazyVim.
    ├── mcp.json
    └── settings.json
```
## Scripts

- `scripts/setup-symlinks.sh`: Links all managed dotfiles from this repo into the expected macOS locations under `$HOME` and app support folders. Existing nonmatching files are moved to `backups/<timestamp>/` before links are created.
  - VS Code `sync/` and `globalStorage/` are intentionally ignored because VS Code writes generated state there.
  - k9s is linked file-by-file so generated cluster state and logs stay outside the repo.
- `scripts/archive/load-dotfiles.sh`: Legacy copy/load script kept for archive.
- `scripts/archive/save-dotfiles.sh`: Legacy copy/save script kept for archive.
