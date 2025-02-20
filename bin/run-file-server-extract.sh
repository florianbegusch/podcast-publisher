#!/usr/bin/env bash

# all of these stem from https://www.shellcheck.net/wiki/
set -o pipefail  # propagate errors
set -u  # exit on undefined
set -e  # exit on non-zero return value
#set -f  # disable globbing/filename expansion
shopt -s failglob  # error on unexpaned globs
shopt -s inherit_errexit  # Bash disables set -e in command substitution by default; reverse this behavior



path=~/.colima/_lima/colima/ssh.config
if [ "${DOCKER_BACKING_INSTANCE:=}" = default ]; then
  path=~/.lima/default/ssh.config
fi

if [ "$1" = id_file ]; then
  grep IdentityFile "$path" | awk -F '"' 'NR==1 { print $2; exit }'
elif [ "$1" = port ]; then
  grep Port "$path" | awk 'NR==1 { print $2; exit }'
fi

