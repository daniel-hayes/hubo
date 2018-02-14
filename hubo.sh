#!/usr/bin/env bash

# hubo == "git(hub) (o)pen"

# help!
options_help="\n
hubo                      \t\t\t\t  open current repo\n
hubo [path] [line number] \t        repo/branch with directory/file path\n
hubo pr                   \t\t\t    repo pull request page\n
hubo issues               \t\t\t    repo issues page\n
hubo help                 \t\t\t    instructions\n
"

# check if we are in git repo
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
  echo 'This is not a git repository.'
  exit 1
fi

if [[ $1 = 'help' ]]; then
  echo -e $options_help
  exit 0
fi

# get remote url
# http(s)://github.com/<REPO>
# git@github.com:<REPO>
remote_url=$(git remote get-url origin)

if [[ $remote_url = *'git@github'* ]]; then
  # strip everything before ':'
  remote_url="https://github.com/${remote_url#*:}"
fi

# strip '.git'
url=${remote_url%.*}

# determine branch so we can add path to url
function getBranch() {
  # get current branch
  local branch=$(git rev-parse --abbrev-ref HEAD)

  # you are detached and we should use commit hash
  if [[ $branch = "HEAD" ]]; then
    branch=$(git rev-parse --verify HEAD) 
  fi

  # return either branch name or commit hash
  echo "$branch"
}

branch=$(getBranch)

if [ $# != 0 ]; then

  # TODO there should be a function for each argument instead of running each time

  # open pull request page
  if [ $1 = 'pr' ]; then
    githuburl="$url/pulls"
  elif [ $1 = 'issues' ]; then
    githuburl="$url/issues"
  else
    # determine file / dir type
    if [[ -d $1 ]]; then
      # argument is a directory
      path_type='tree'
    elif [[ -f $1 ]]; then
      # argument is a file
      path_type='blob'

      # add line number anchor to end of url with additonal argument
      if [[ ! -z $2 ]] && [[ $2 -ge 0 ]]; then
        line_number="#L$2"
      fi

    else
      echo 'hubo: invalid argument'
      echo -e $options_help
      exit 1
    fi

    relative_to_root=$(git rev-parse --show-prefix)

    # full path including branch
    githuburl="$url/$path_type/$branch/$relative_to_root$1$line_number"
  fi

else
  # full path to repo
  githuburl="$url/tree/$branch"
fi

# open in browser
open $githuburl
