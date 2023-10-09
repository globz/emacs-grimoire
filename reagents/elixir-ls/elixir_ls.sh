#!/bin/bash

elixir_ls()
{

    local env=$1
    local predefined_selection=$2
    local wd=$(pwd)
    local version="v0.16.0"
    local elixir_ls_deps_dir="${wd}/emacs-deps/language-server/elixir-ls-${version}"
    local repo="https://github.com/elixir-lsp/elixir-ls/releases/download/${version}/elixir-ls-${version}.zip"
    local eglot_conf_path="~/emacs-grimoire/emacs-deps/language-server/elixir-ls-${version}/language_server.sh"

    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Download elixir-ls (language-server)\e[m"
    echo -e "\e[0;35m2 - List available elixir-ls versions\e[m"

    if [[ ! -z "$predefined_selection" ]]
    then
        ACTION=$predefined_selection
    else
        read -p 'Choice: ' ACTION
    fi

    if [ "$ACTION" == 1 ]
    then
        spellpouch -p "dialog_prompt" -e "You are about to download elixir-ls, press any key to continue or C-c to abort..."
        mkdir -p "${elixir_ls_deps_dir}" && cd "${elixir_ls_deps_dir}" && wget "${repo}"
        sudo apt install unzip
        unzip "elixir-ls-${version}.zip"
        echo -e "\033[31m Update your eglot emacs-conf with the following path: ${eglot_conf_path}\e[m"
        echo -e "\033[31m Older versions of elixir-ls will still remains in ${wd}/emacs-deps/language-server/ \e[m"
    fi

    if [ "$ACTION" == 2 ]
    then
        cd "${wd}/emacs-deps/language-server/" && ls -d elixir-ls-*
        echo -e "\033[31m You may update your eglot emacs-conf with one of the following version above.\e[m"
        echo -e "\033[31m ~/emacs-grimoire/emacs-deps/language-server/elixir-ls-[version]/language_server.sh\e[m"
    fi

}
