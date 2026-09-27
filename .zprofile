# Initialize Homebrew for login shells.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prefer rustup's Rust toolchain over Homebrew's after shellenv runs.
if [[ -d "$HOME/.cargo/bin" ]]; then
  path=("$HOME/.cargo/bin" ${path:#"$HOME/.cargo/bin"})
  export PATH
fi

# Prefer the native Go installation over Homebrew's.
if [[ -d /usr/local/go/bin ]]; then
  path=(/usr/local/go/bin ${path:#/usr/local/go/bin})
  export PATH
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

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
