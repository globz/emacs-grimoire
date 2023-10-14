#!/bin/bash

emacs_ispell()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)
    local ispell_deps_dir="${wd}/reagents/emacs-ispell/ispell/french_dict"

    echo "The following option is available, please make a choice ::"
    echo -e "\e[0;35m1 - Install ispell french dict\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [[ "$ACTION" == 1 ]]
    then
        sudo cp "${ispell_deps_dir}/francais.aff" /usr/lib/ispell/.
        sudo cp "${ispell_deps_dir}/francais.hash" /usr/lib/ispell/.

        echo -e "\033[31m ispell french dictionary is now installed\e[m"
    fi

}
