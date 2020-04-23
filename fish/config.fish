# gettext
set -g fish_user_paths "/usr/local/opt/gettext/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/gettext/lib"
set -gx CPPFLAGS "-I/usr/local/opt/gettext/include"

# Load anyenv automatically by adding
status --is-interactive; and source (anyenv init -|psub)

source ~/.myenv/bin/activate.fish

# aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias fvim='nvim ~/.config/fish/config.fish'
alias vvim='nvim ~/.config/nvim/init.vim'

alias rm='rmtrash'
alias l='ls'

# prompt theme
set -x pure_color_git_branch dddddd
