#!/bin/bash

emacs_conf()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)
    local emacs_deps_dir="${wd}/emacs-deps"
    local emacs_conf_dir="${emacs_deps_dir}/emacs-conf"
    local repo="https://github.com/globz/emacs-conf.git"

    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Download emacs-conf [git clone]\e[m"
    echo -e "\e[0;35m2 - Configure Emacs [fresh installation]\e[m"
    echo -e "\e[0;35m3 - Update init.org\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [[ "$ACTION" == 1 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to git clone emacs-conf, press any key to continue or C-c to abort..."
        mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && git clone "${repo}"
    fi

    if [[ "$ACTION" == 2 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to configure Emacs with emacs-conf, press any key to continue or C-c to abort..."
        spellpouch -p "dialog_prompt" -e "!WARNING! this option should only be used after a fresh installation, press any key to continue or C-c to abort..."

        if spellpouch -p "create_backup"
        then
            spellpouch -p "dialog_prompt" -e "Backup completed, do you wish to proceed with the removal of your current configuration?, press any key to continue or C-c to abort..."
            spellpouch -p "dialog_prompt" -e "!WARNING! DESTRUCTIVE actions incoming \(you will be prompted for each actions\), press any key to continue or C-c to abort..."


            RM_INIT_ORG=~/.emacs.d/init.org
            if [[ -f "$RM_INIT_ORG" ]]; then
                spellpouch -p "dialog_prompt" -e "!WARNING! DESTRUCTIVE actions incoming, removing [init.org] press any key to continue or C-c to abort..."
                rm -iv ~/.emacs.d/init.org
            fi

            RM_INIT_EL=~/.emacs.d/init.el
            if [[ -f "$RM_INIT_EL" ]]; then
                spellpouch -p "dialog_prompt" -e "!WARNING! DESTRUCTIVE actions incoming, removing [init.el] press any key to continue or C-c to abort..."
                rm -iv ~/.emacs.d/init.el
            fi

            RM_INIT_ELC=~/.emacs.d/init.elc
            if [[ -f "$RM_INIT_ELC" ]]; then
                spellpouch -p "dialog_prompt" -e "!WARNING! DESTRUCTIVE actions incoming, removing [init.elc] press any key to continue or C-c to abort..."
                rm -iv ~/.emacs.d/init.elc
            fi

            RM_ELPA_DIR=~/.emacs.d/elpa
            if [[ -d "$RM_ELPA_DIR" ]]; then
                spellpouch -p "dialog_prompt" -e "!WARNING! DESTRUCTIVE actions incoming, emptying directory [elpa] press any key to continue or C-c to abort..."
                rm -iv -rf ~/.emacs.d/elpa/*
            fi

            spellpouch -p "dialog_prompt" -e "Updating ~/.emacs.d/ with emacs-conf/init.org, press any key to continue or C-c to abort..."
            cp "${emacs_conf_dir}/init.org" ~/.emacs.d/.
            spellpouch -p "dialog_prompt" -e "Updating ~/.emacs.d/ with emacs-conf/init.el, press any key to continue or C-c to abort..."
            cp "${emacs_conf_dir}/init.el" ~/.emacs.d/.
            echo -e "\033[31m init.org and init.el have been updated successfully\e[m"
        else
            echo "Backup failed! Aborting!"
            return 1
        fi
    fi

    if [[ "$ACTION" == 3 ]]
    then
        spellpouch -p "dialog_prompt" -e "You are about to update emacs-conf [git pull], press any key to continue or C-c to abort..."
        cd "${emacs_deps_dir}/emacs-conf" && git pull "${repo}"
        cd -
        spellpouch -p "dialog_prompt" -e "Would you also like to update ~/.emacs.d/init.org?, press any key to continue or C-c to abort..."
        cp "${emacs_conf_dir}/init.org" ~/.emacs.d/.
        echo -e "\033[31m init.org has been updated successfully\e[m"
        echo -e "\033[31m In order to update Emacs configuration (tangle-init) must be invoked \e[m"
        echo -e "\033[31m Is Emacs currently running? \e[m"
        read -p 'Answer (y/n): ' ANSWER

        if [ "$ANSWER" == "y" ]
        then
            echo -e "\033[31m Opening ~/.emacs.d/init.org with emacsclient and evaluating (tangle-init) \e[m"
            spellpouch -p "dialog_prompt" -e "Would you like to \(tangle-init\) ~/.emacs.d/init.org now?, press any key to continue or C-c to abort..."
            emacsclient -q --eval '(progn (find-file "~/.emacs.d/init.org") (tangle-init))'
        else
            echo -e "\033[31m You may now (tangle-init) your ~/.emacs.d/init.org manually\e[m"
        fi

    fi

}
