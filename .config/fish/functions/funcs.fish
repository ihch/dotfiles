# google-chrome
function chrome
  set -l url
  if [ "$argv[1]" = "" ]
    set url "google.com"
  else
    set url $argv[1]
  end
  echo $url
  /mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe $url
end

# cd_ls
function cd
  builtin cd $argv[1]
  ls
end

# copy to clip
function copy
  cat $argv[1] | clip
end
