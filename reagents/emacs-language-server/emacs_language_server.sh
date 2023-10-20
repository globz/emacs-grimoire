#!/bin/bash

emacs_language_server()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)

    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Install language servers\e[m"
    echo -e "\e[0;35m2 - Update language servers\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [[ "$ACTION" == 1 ]]
    then
        echo -e "\033[31m Which language server would you like to install?\e[m"
        echo -e "\e[0;35m1 - Install [elixir]\e[m"
        echo -e "\e[0;35m2 - Install [bash]\e[m"
        echo -e "\e[0;35m3 - Install [typescript/JavaScript]\e[m"
        echo -e "\e[0;35m4 - Install [PHP]\e[m"
        read -p 'Choice: ' LS_INSTALL_CHOICE

        if [[ "$LS_INSTALL_CHOICE" == 1 ]]
        then
            echo -e "\e[0;35m2 - Installing [elixir] language-server\e[m"
            spellpouch -p "language_server" -s "install_elixir_ls" -e "v0.17.1"
        fi

        if [[ "$LS_INSTALL_CHOICE" == 2 ]]
        then
            echo -e "\e[0;35mw - Installing [bash] language-server\e[m"
            spellpouch -p "ls_ts_reqs"
            spellpouch -p "language_server" -s "install_bash_ls"
        fi

        if [[ "$LS_INSTALL_CHOICE" == 3 ]]
        then
            echo -e "\e[0;35m3 - Installing [typescript/JavaScript] language-server\e[m"
            spellpouch -p "ls_ts_reqs"
            spellpouch -p "language_server" -s "install_javascript_ls"
        fi

        if [[ "$LS_INSTALL_CHOICE" == 4 ]]
        then
            echo -e "\e[0;35m4 - Installing [PHP] language-server\e[m"
            spellpouch -p "ls_ts_reqs"
            spellpouch -p "language_server" -s "install_php_ls"
        fi

    fi

    if [ "$ACTION" == 2 ]
    then
        echo -e "\033[31m Which language server would you like to install?\e[m"
        echo -e "\e[0;35m1 - Update [elixir]\e[m"
        echo -e "\e[0;35m2 - Update [bash]\e[m"
        echo -e "\e[0;35m3 - Update [typescript/JavaScript]\e[m"
        echo -e "\e[0;35m4 - Update [PHP]\e[m"
        read -p 'Choice: ' LS_UPDATE_CHOICE

        if [[ "$LS_UPDATE_CHOICE" == 1 ]]
        then
            echo -e "\e[0;35m1 - Updating [elixir] language-server\e[m"
            spellpouch -p "language_server" -s "update_elixir_ls"
        fi

        if [[ "$LS_UPDATE_CHOICE" == 2 ]]
        then
            echo -e "\e[0;35m2 - Updating [bash] language-server\e[m"
            spellpouch -p "language_server" -s "update_bash_ls"
        fi

        if [[ "$LS_UPDATE_CHOICE" == 3 ]]
        then
            echo -e "\e[0;35m3 - Updating [typescript/JavaScript] language-server\e[m"
            spellpouch -p "language_server" -s "update_javascript_ls"
        fi

        if [[ "$LS_UPDATE_CHOICE" == 4 ]]
        then
            echo -e "\e[0;35m4 - Updating [PHP] language-server\e[m"
            spellpouch -p "language_server" -s "update_php_ls"
        fi
    fi

}
