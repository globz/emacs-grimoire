#!/bin/bash

elixir_ls()
{

  local env=$1
  local predefined_selection=$2
  local wd=$(pwd)
  local ls_deps_dir="${wd}/emacs-deps/language-server"
  local version="v0.16.0"
  local repo="https://github.com/elixir-lsp/elixir-ls/releases/download/${version}/elixir-ls-${version}.zip"
  
   # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"
  
  echo "The following options are available, please make a choice ::"
  echo -e "\e[0;35m1 - fetch elixir-ls (language-server)\e[m"
  echo -e "\e[0;35m2 - update emacs-conf\e[m"
  
  if [[ ! -z "$predefined_selection" ]]
  then
      ACTION=$predefined_selection
  else
      read -p 'Choice: ' ACTION
  fi

  if [ "$ACTION" == 1 ]
  then
    spellpouch -p "dialog_prompt" -e "You are about to download elixir-ls, press any key to continue or C-c to abort..."
    mkdir -p "${ls_deps_dir}" && cd "${ls_deps_dir}" && wget "${repo}"
    sudo apt install unzip
    unzip "elixir-ls-${version}.zip"
  fi

  if [ "$ACTION" == 2 ]
  then
    spellpouch -p "dialog_prompt" -e "You are about to update elixir-ls, press any key to continue or C-c to abort..."
  fi

}
