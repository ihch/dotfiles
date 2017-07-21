# anyenv
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

