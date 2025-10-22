#!/bin/bash

ls_ts_reqs()
{

    local nvm_version="v0.40.3"
    local node_version="v22.20"

    if ! command -v wget &> /dev/null
    then
        echo -e "\033[31m <wget> could not be found\e[m"
        echo -e "\033[31m Installing wget...\e[m"
        sudo apt install wget
        # TODO on Ubuntu 25.0 Server wcurl will become the default and replace wget...
    fi
    
    if [ -f ~/.nvm/nvm.sh ];
    then
        echo -e "\033[31m nvm is already installed\e[m"
        . ~/.bashrc
        . ~/.nvm/nvm.sh
        nvm --version
    else
        echo -e "\033[31m nvm (Node Version Manager) could not be found\e[m"
        echo -e "\033[31m Node is required for language servers using TypeScript\e[m"
        echo -e "\033[31m nvm is a must to manage all this mess of an ecosystem...enjoy\e[m"
        echo -e "\033[31m Installing nvm ${nvm_version} and Node ${node_version}\e[m"

        wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh | bash

        . ~/.bashrc
        . ~/.nvm/nvm.sh
        nvm install "${node_version}" && nvm list
    fi

}
