#!/bin/bash

elixir_ls()
{

  local env=$1
  local predefined_selection=$2
  local wd=$(pwd)
  local version="v0.16.0"
  local ls_deps_dir="${wd}/emacs-deps/language-server/elixir-ls-${version}"
  local repo="https://github.com/elixir-lsp/elixir-ls/releases/download/${version}/elixir-ls-${version}.zip"
  
   # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"
  
  echo "The following options are available, please make a choice ::"
  echo -e "\e[0;35m1 - Download elixir-ls (language-server)\e[m"
  
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
    echo -e "\nUpdate your eglot emacs-conf with the following path: ${ls_deps_dir}/language_server.sh"
    echo -e "\nOlder versions of elixir-ls will still remains in ${wd}/emacs-deps/language-server/"
  fi


}
