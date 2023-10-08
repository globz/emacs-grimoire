#!/bin/bash

make_emacs()
{

  local env=$1
  local predefined_selection=$2
  local wd=$(pwd)
  local version="29.1"
  local emacs_src_dir="${wd}/emacs-src"
  local emacs_backup_dir="${wd}/emacs-backup"
  local emacs_src_url="http://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.xz"
  local current_date_time=$(date +"%m-%d-%y_%H-%M-%S")

   # Sourcing spellpouch from working directory (user grimoire)
  source "${wd}/spells/spellpouch.sh"

  echo "The following options are available, please make a choice ::"
  echo -e "\e[0;35m1 - Download Emacs source\e[m"
  echo -e "\e[0;35m2 - Build Emacs from source\e[m"
  echo -e "\e[0;35m3 - Uninstall Emacs from source\e[m"
  echo -e "\e[0;35m4 - List available Emacs builds\e[m"

  if [[ ! -z "$predefined_selection" ]]
  then
      ACTION=$predefined_selection
  else
      read -p 'Choice: ' ACTION
  fi

  if [ "$ACTION" == 1 ]
  then
    spellpouch -p "dialog_prompt" -e "You are about to download Emacs source, press any key to continue or C-c to abort..."
    spellpouch -p "dialog_prompt" -e "Please make sure to update this script version variable before proceeding, press any key to continue or C-c to abort..."

    mkdir -p "${emacs_src_dir}" && cd "${emacs_src_dir}" && wget "${emacs_src_url}"
    sudo apt install xz-utils
    tar -xf "emacs-${version}.tar.xz"
  fi
  
  if [ "$ACTION" == 2 ]
  then
    spellpouch -p "dialog_prompt" -e "You are about to build & install Emacs from source, press any key to continue or C-c to abort..."
    spellpouch -p "dialog_prompt" -e "Please make sure to uninstall your current Emacs version before proceeding, press any key to continue or C-c to abort..."
  fi

  if [ "$ACTION" == 3 ]
  then
      spellpouch -p "dialog_prompt" -e "You are about to uninstall Emacs from source, press any key to continue or C-c to abort..."
      spellpouch -p "dialog_prompt" -e "Please select a version from the list below..., press any key to continue or C-c to abort..."

      cd "${emacs_src_dir}" && ls -d emacs-*

      read -p 'Choice (i.e emacs-29.1): ' UNINSTALL_THIS_VERSION

      echo -e "\033[31m Creating backup of ~/.emacs.d\e[m"
      mkdir -p "${emacs_backup_dir}/emacsd-${current_date_time}" && cp ~/.emacs.d/ "${emacs_backup_dir}/emacsd-${current_date_time}/."
      
      spellpouch -p "dialog_prompt" -e "Backup completed, do you wish to proceed and uninstall ${UNINSTALL_THIS_VERSION}?, press any key to continue or C-c to abort..."

      cd "${emacs_src_dir}/${UNINSTALL_THIS_VERSION}" && make uninstall
  fi

  if [ "$ACTION" == 4 ]
  then
      cd "${emacs_src_dir}" && ls -d emacs-*
      echo -e "\033[31m You may build & install Emacs with witchesbrew mix make-emacs -e LINUX 2.\e[m"
      echo -e "\033[31m You may uninstall Emacs with witchesbrew mix make-emacs -e LINUX 3.\e[m"
  fi

}
