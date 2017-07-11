. /home/nemu_sou/.config/fish/private.fish

# alias {{{
alias home "cd /mnt/c/Users/$USER_NAME"
alias desktop "cd /mnt/c/Users/$USER_NAME/Desktop"
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

# }}}

