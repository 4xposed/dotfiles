set -x TERM xterm-256color
set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
set -gx OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES

source ~/.asdf/asdf.fish

set -g fish_user_paths "/usr/local/opt/node@8/bin" $fish_user_paths
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

alias bi "bundle install"
alias be "bundle exec"
alias bu "bundle update"
