if [[ -s "${HOME}/.profile" ]] && [[ "${PROFILE_LOADED:0}" != 1 ]]
  then source "${HOME}/.profile"
fi