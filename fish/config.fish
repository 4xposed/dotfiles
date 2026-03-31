if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.docker/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.custom/bin

fish_add_path $HOME/bins

set -gx PATH (brew --prefix)/opt/python/libexec/bin $PATH
export PATH="$HOME/.local/bin:$PATH"
set -gx SAFEHOUSE_APPEND_PROFILE "$HOME/.config/agent-safehouse/local-overrides.sb"
