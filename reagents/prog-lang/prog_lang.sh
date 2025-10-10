#!/bin/bash

prog_lang()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)

    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Install Erlang/Elixir\e[m"
    echo -e "\e[0;35m2 - Install PHP\e[m"
    echo -e "\e[0;35m3 - Install Scheme\e[m"
    echo -e "\e[0;35m4 - Install Lisp [SBCL]\e[m"
    echo -e "\e[0;35m5 - Install Python\e[m"
    echo -e "\e[0;35m6 - Install R\e[m"
    echo -e "\e[0;35m7 - Install Odin\e[m"    

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [ "$ACTION" == 1 ]
    then
        echo -e "\033[31m Installing Erlang/Elixir...\e[m"
        spellpouch -p "asdf" -s "install"
        spellpouch -p "runtime" -s "erlang_elixir" -e "27.3.4.3" "1.18.4-otp-27"
    fi

    if [ "$ACTION" == 2 ]
    then
        echo -e "\033[31m Installing PHP...\e[m"
    fi

    if [ "$ACTION" == 3 ]
    then
        echo -e "\033[31m Which Scheme interpreter would you like to install?\e[m"
        echo -e "\e[0;35m1 - Install [chez] with asdf\e[m"
        echo -e "\e[0;35m2 - Install [mit] from source\e[m"
        echo -e "\e[0;35m3 - Install [racket] with asdf\e[m"
        read -p 'Choice: ' SCHEME_INSTALL_CHOICE

        if [[ "$SCHEME_INSTALL_CHOICE" == 1 ]]
        then
            echo -e "\033[31m Installing Chez Scheme...\e[m"
            spellpouch -p "asdf" -s "install"
            spellpouch -p "runtime" -s "chez_scheme" -e "9.6.4"
        fi

        if [[ "$SCHEME_INSTALL_CHOICE" == 2 ]]
        then

            echo "The following options are available, please make a choice ::"
            echo -e "\e[0;35m1 - Download mit-scheme source\e[m"
            echo -e "\e[0;35m2 - Build mit-scheme from source\e[m"
            echo -e "\e[0;35m3 - Install mit-scheme from source\e[m"
            echo -e "\e[0;35m4 - Uninstall mit-scheme from source\e[m"
            read -p 'Choice: ' COMMAND_CHOICE

            if [[ "$COMMAND_CHOICE" == 1 ]]
            then
                spellpouch -p "dialog_prompt" -e "You are about to download mit-scheme source, press any key to continue or C-c to abort..."
                spellpouch -p "runtime" -s "mit_scheme_download" -e "12.1"
            fi

            if [[ "$COMMAND_CHOICE" == 2 ]]
            then
                spellpouch -p "dialog_prompt" -e "You are about to build mit-scheme from source, press any key to continue or C-c to abort..."
                spellpouch -p "runtime" -s "mit_scheme_build" -e "12.1"
            fi

            if [[ "$COMMAND_CHOICE" == 3 ]]
            then
                spellpouch -p "dialog_prompt" -e "You are about to install mit-scheme from source, press any key to continue or C-c to abort..."
                spellpouch -p "runtime" -s "mit_scheme_install" -e "12.1"
            fi

            if [[ "$COMMAND_CHOICE" == 4 ]]
            then
                spellpouch -p "dialog_prompt" -e "You are about to uninstall mit-scheme from source, press any key to continue or C-c to abort..."
                spellpouch -p "runtime" -s "mit_scheme_uninstall"
            fi

        fi

        if [[ "$SCHEME_INSTALL_CHOICE" == 3 ]]
        then
            echo -e "\033[31m Installing Racket Scheme...\e[m"
            spellpouch -p "asdf" -s "install"
            spellpouch -p "runtime" -s "racket_scheme" -e "8.10"
        fi        
    fi

    if [ "$ACTION" == 4 ]
    then
        echo -e "\033[31m Installing Lisp [SBCL]...\e[m"
    fi

    if [ "$ACTION" == 5 ]
    then
        echo -e "\033[31m Installing Python...\e[m"
        spellpouch -p "asdf" -s "install"
        spellpouch -p "runtime" -s "python" -e "3.10.12"
    fi

    if [ "$ACTION" == 7 ]
    then
        echo -e "\033[31m Installing Odin...\e[m"
        spellpouch -p "asdf" -s "install"
        spellpouch -p "runtime" -s "odin" -e "dev-2024-02"
    fi    

}
