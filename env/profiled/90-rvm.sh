# Prepare env for RVM
# shellcheck disable=SC1091
PATH="${PATH}:${HOME}/.rvm/bin"

if test -d "${HOME}/.rvm/bin"
  then PATH="${PATH}:${HOME}/.rvm/bin"
fi

if test -s "${HOME}/.rvm/scripts/rvm"
  then . "${HOME}/.rvm/scripts/rvm"
fi