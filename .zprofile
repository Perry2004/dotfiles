# Initialize Homebrew for login shells.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# User-local executables.
path=("$HOME/.local/bin" ${path:#"$HOME/.local/bin"})
export PATH

# Include GNU Make's gnumake in PATH, so `make` uses it instead of macOS make.
gnumake_path="/opt/homebrew/opt/make/libexec/gnubin"
if [[ -d "$gnumake_path" ]]; then
  path=("$gnumake_path" ${path:#"$gnumake_path"})
  export PATH
fi
unset gnumake_path

# OrbStack command-line tools and integration.
if [[ -r "$HOME/.orbstack/shell/init.zsh" ]]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags.
export ARCHFLAGS="-arch $(uname -m)"
