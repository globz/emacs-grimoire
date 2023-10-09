#!/bin/bash

create_backup()
{

  local wd=$(pwd)
  local emacs_backup_dir="${wd}/emacs-backup"
  local current_date_time=$(date +"%m-%d-%y_%H-%M-%S")

  mkdir -p "${emacs_backup_dir}/emacs.d-${current_date_time}"

  echo -e "\033[31m Creating backup of ~/.emacs.d\e[m"
  
  if cp -r ~/.emacs.d/ "${emacs_backup_dir}/emacs.d-${current_date_time}/."
  then
     echo "Backup: $? - Successful"
     return 0
  else
      echo "Backup: $? - Unsuccessful"
      return 1
  fi  

}
