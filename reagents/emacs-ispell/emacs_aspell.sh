#!/bin/bash

emacs_aspell()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)

    echo "The following option is available, please make a choice ::"
    echo -e "\e[0;35m1 - Install aspell french dict\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [[ "$ACTION" == 1 ]]
    then
        sudo apt install aspell-fr
        echo -e "\033[31m aspell french dictionary is now installed\e[m"
    fi

}
