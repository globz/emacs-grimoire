#!/bin/bash

install_elixir_ls()
{

    local wd=$(pwd)
    local version=$1

    echo -e "\033[31m Default version is current set to ${version}.\e[m"
    echo -e "\033[31m Would you like to input another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        version=$USER_VERSION
    fi

    local elixir_ls_repo="https://github.com/elixir-lsp/elixir-ls/releases/download/${version}/elixir-ls-${version}.zip"
    local elixir_ls_install_dir="${wd}/emacs-deps/language-server/elixir-ls-${version}"

    echo -e "\033[31m Downloading elixir-ls-${version}\e[m"
    echo -e '\e]8;;https://github.com/elixir-lsp/elixir-ls\a[github] elixir-language-server\e]8;;\a'
    mkdir -p "${elixir_ls_install_dir}" && cd "${elixir_ls_install_dir}" && wget "${elixir_ls_repo}"

    if ! command -v unzip &> /dev/null
    then
        echo -e "\033[31m <unzip> could not be found\e[m"
        echo -e "\033[31m Installing unzip...\e[m"
        sudo apt install unzip
    fi

    unzip "elixir-ls-${version}.zip"

    echo -e "\033[31m Update your eglot emacs-conf/init.org with the following path: ${elixir_ls_install_dir}/language_server.sh\e[m"
    echo -e "\033[31m Older versions of elixir-ls will still remain in ${wd}/emacs-deps/language-server/ \e[m"

}

install_bash_ls()
{

    echo -e "\033[31m Downloading and installing bash-language-server...\e[m"
    echo -e '\e]8;;https://github.com/bash-lsp/bash-language-server\a[github] bash-language-server\e]8;;\a'
    npm i -g bash-language-server
}

install_javascript_ls()
{

    echo -e "\033[31m Downloading and installing typescript-language-server...\e[m"
    echo -e '\e]8;;https://github.com/typescript-language-server/typescript-language-server\a[github] typescript-language-server\e]8;;\a'
    npm i -g typescript-language-server typescript
}

install_php_ls()
{

    echo -e "\033[31m Downloading and installing intelephense-language-server...\e[m"
    echo -e '\e]8;;https://github.com/bmewburn/vscode-intelephense\a[github] intelephense-language-server\e]8;;\a'
    npm i -g intelephense
}

update_elixir_ls()
{

    local wd=$(pwd)

    cd "${wd}/emacs-deps/language-server/" && ls -d elixir-ls-*
    echo -e "\033[31m You may update your eglot emacs-conf with one of the following version above.\e[m"
    echo -e "\033[31m ${wd}/emacs-deps/language-server/elixir-ls-[version]/language_server.sh\e[m"

}

update_bash_ls()
{

    echo -e "\033[31m Updating bash-language-server...\e[m"
    npm update -g bash-language-server

}

update_javascript_ls()
{

    echo -e "\033[31m Updating typescript-language-server...\e[m"
    npm update -g typescript-language-server

}

update_php_ls()
{

    echo -e "\033[31m Updating typescript-language-server...\e[m"
    npm update -g intelephense

}
