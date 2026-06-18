# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    colored-man-pages
    extract
    copypath
    zsh-syntax-highlighting
    zsh-autosuggestions
    brew
    direnv
    terraform
)

# Docker CLI completions must be in fpath before Oh My Zsh runs compinit.
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

icloud="${HOME}/Library/Mobile Documents/com~apple~CloudDocs"
files="${icloud}/Files"
term="${files}/UBC/2024WT2"
codes="${files}/Codes"
books="${HOME}/Library/Mobile Documents/iCloud~com~apple~iBooks/Documents"
notes="${HOME}/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes.md"
plai="${files}/PLAI"

# aliases
alias lg='lazygit'
alias lzd="lazydocker"
alias gcln='gitclean'

# vim mapping
set -o vi

# custom functions
function cdl() {
    cd "$1" && ll
}

function gitclean() {
    git switch $(git_main_branch)
    git pull -p
    git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
}


# iterm2 shell integration
[[ -r "${HOME}/.iterm2_shell_integration.zsh" ]] && source "${HOME}/.iterm2_shell_integration.zsh"

# asdf runtime management
asdf_shims="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
if [[ -d "$asdf_shims" ]]; then
  path=("$asdf_shims" ${path:#"$asdf_shims"})
  export PATH
fi
unset asdf_shims

# asdf go plugins
asdf_go_env="${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/golang/set-env.zsh"
[[ -r "$asdf_go_env" ]] && source "$asdf_go_env"
unset asdf_go_env

# yarn path
if [[ -d "${HOME}/.yarn/bin" ]]; then
  path=("${HOME}/.yarn/bin" ${path:#"${HOME}/.yarn/bin"})
  export PATH
fi

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#compdef pnpm
###-begin-pnpm-completion-###
if type compdef &>/dev/null; then
  _pnpm_completion () {
    local reply
    local si=$IFS

    IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}"))
    IFS=$si

    if [ "$reply" = "__tabtab_complete_files__" ]; then
      _files
    else
      _describe 'values' reply
    fi
  }
  # When called by the Zsh completion system, this will end with
  # "loadautofunc" when initially autoloaded and "shfunc" later on, otherwise,
  # the script was "eval"-ed so use "compdef" to register it with the
  # completion system
  if [[ $zsh_eval_context == *func ]]; then
    _pnpm_completion "$@"
  else
    compdef _pnpm_completion pnpm
  fi
fi
###-end-pnpm-completion-###

# starship
if command -v starship >/dev/null 2>&1 && [[ -t 1 && "$TERM" != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

# yazi shell wrapper
function y() {
	if ! command -v yazi >/dev/null 2>&1; then
		echo "yazi: command not found" >&2
		return 127
	fi

	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	local status=$?
	if [[ "$status" -ne 0 ]]; then
		rm -f -- "$tmp"
		return "$status"
	fi

	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf
export FZF_DEFAULT_OPTS="--height 80% --tmux center,80% --style full --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1 && [[ -t 0 && -t 1 && "$TERM" != "dumb" ]]; then
  source <(fzf --zsh)
fi

# Auto-complete for make
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:*:make:*:targets' call-command no
