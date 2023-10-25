# Terminal settings
set -x TERM xterm-256color
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Load Rust bins
fish_add_path $HOME/.cargo/bin

# Use GNU Core Utils
fish_add_path /usr/local/opt/coreutils/libexec/gnubin

# Use GNU tar
fish_add_path /opt/homebrew/opt/gnu-tar/libexec/gnubin

# MAC OS shenanigans
set -gx OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

# Add homebrew bin directory
fish_add_path /opt/homebrew/bin

# Load ASDF
source ~/.asdf/asdf.fish

# GOPATH and GOROOT
set -gx GOPATH $(asdf where golang)/packages
set -gx GOROOT $(asdf where golang)/go
fish_add_path "$(go env GOPATH)/bin"
