#!/bin/bash

make_emacs()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)
    local emacs_src_dir="${wd}/emacs-src"

    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Download Emacs source\e[m"
    echo -e "\e[0;35m2 - Build Emacs from source\e[m"
    echo -e "\e[0;35m3 - Install Emacs from source\e[m"
    echo -e "\e[0;35m4 - Uninstall Emacs from source\e[m"
    echo -e "\e[0;35m5 - List available Emacs builds\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [[ "$ACTION" == 1 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to download Emacs source, press any key to continue or C-c to abort..."
        spellpouch -p "emacs_manager" -s "download_src" -e "29.4"
    fi

    if [[ "$ACTION" == 2 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to build Emacs from source, press any key to continue or C-c to abort..."
        spellpouch -p "emacs_manager" -s "build_src" -e "29.4"
    fi

    if [[ "$ACTION" == 3 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to install Emacs from source, press any key to continue or C-c to abort..."
        spellpouch -p "dialog_prompt" -e "Please make sure to uninstall your current Emacs version before proceeding, press any key to continue or C-c to abort..."

        if spellpouch -p "create_backup"
        then
            spellpouch -p "dialog_prompt" -e "Backup completed, do you wish to proceed and install Emacs?, press any key to continue or C-c to abort..."
            spellpouch -p "emacs_manager" -s "install_src" -e "29.4"
        else
            echo "Backup failed!"
            return 1
        fi
    fi

    if [[ "$ACTION" == 4 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to uninstall Emacs from source, press any key to continue or C-c to abort..."

        if spellpouch -p "create_backup"
        then
            spellpouch -p "dialog_prompt" -e "Backup completed, do you wish to proceed and uninstall Emacs?, press any key to continue or C-c to abort..."
            spellpouch -p "emacs_manager" -s "uninstall_src"
        else
            echo "Backup failed!"
            return 1
        fi
    fi

    if [[ "$ACTION" == 5 ]]
    then
        cd "${emacs_src_dir}" && ls -d emacs-* | grep -o "[0-9].*"
        echo -e "\033[31m You may build Emacs from source with witchesbrew mix make-emacs -e LINUX 2.\e[m"
        echo -e "\033[31m You may install Emacs from source with witchesbrew mix make-emacs -e LINUX 3.\e[m"
        echo -e "\033[31m You may uninstall Emacs with witchesbrew mix make-emacs -e LINUX 4.\e[m"
    fi

}
