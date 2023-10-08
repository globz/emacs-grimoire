#!/bin/bash

emacs_conf()
{

  local env=$1
  local predefined_selection=$2
  local wd=$(pwd)
  local emacs_deps_dir="${wd}/emacs-deps"
  local repo="https://github.com/globz/emacs-conf.git"

   # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"
  
  echo "The following options are available, please make a choice ::"
  echo -e "\e[0;35m1 - fetch emacs-conf\e[m"
  echo -e "\e[0;35m3 - configure Emacs with emacs-conf\e[m"
  echo -e "\e[0;35m3 - update emacs-conf\e[m"
  
  if [[ ! -z "$predefined_selection" ]]
  then
      ACTION=$predefined_selection
  else
      read -p 'Choice: ' ACTION
  fi

  if [ "$ACTION" == 1 ]
  then
    spellpouch -p "dialog_prompt" -e "You are about to fetch emacs-conf, press any key to continue or C-c to abort..."
    cd "${emacs_deps_dir}" && git clone "${repo}"
  fi



}
