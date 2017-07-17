. /home/nemu_sou/.config/fish/private.fish
. /home/nemu_sou/.config/fish/functions/fish_prompt.fish

. ~/.mintty-colors-solarized/sol.dark
set dircolors ~/dircolors-solarized/dircolors.ansi-dark

# linuxbrew
set -x PATH "$HOME/.linuxbrew/bin" $PATH
set -x MANPATH "$HOME/.linuxbrew/share/man" $MANPATH
set -x INFOPATH "$HOME/.linuxbrew/share/info" $INFOPATH

set -x XDG_CONFIG_HOME ~/.config

# alias {{{
alias home "cd /mnt/c/Users/$USER_NAME"
alias desktop "cd /mnt/c/Users/$USER_NAME/Desktop"
alias vim "vim -p"
alias vim "nvim"
# }}}

# my function {{{
# google-chrome
function chrome
  set -l url
  if [ -n "$argv[1]" ]
    set url "google.com"
  else
    set url $argv[1]
  end
  /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $url
end

# cd_ls
function cd
  builtin cd $argv[1]
  ls
end
# }}}

# anyenv {{{
set --export PATH  "$HOME/.anyenv/bin" $PATH
source "/home/nemu_sou/.anyenv/libexec/../completions/anyenv.fish"
function anyenv
  set command $argv[1]
  set -e argv[1]

  command anyenv "$command" $argv
end

# pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$HOME/.anyenv/envs/pyenv/bin"
# pyenv init - fish
set -gx PATH '/home/nemu_sou/.anyenv/envs/pyenv/shims' $PATH
set -gx PYENV_SHELL fish
source '/home/nemu_sou/.anyenv/envs/pyenv/libexec/../completions/pyenv.fish'
command pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end

# }}}
