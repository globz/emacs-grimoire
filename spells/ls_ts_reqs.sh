#!/bin/bash

ls_ts_reqs()
{

    local nvm_version="v0.40.3"
    local node_version="v22.20"
    local check_type=$(type -t nvm)

    if [[ ${check_type} != "function" ]]
    then
        echo -e "\033[31m nvm (Node Version Manager) could not be found\e[m"
        echo -e "\033[31m Node is required for language servers using TypeScript\e[m"
        echo -e "\033[31m nvm is a must to manage all this mess of an ecosystem...enjoy\e[m"
        echo -e "\033[31m Installing nvm ${nvm_version} and Node ${node_version}\e[m"

        curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/${nvm_version}/install.sh" | bash

        . ~/.bashrc
        . ~/.nvm/nvm.sh
        nvm install "${node_version}" && nvm list
    fi

}
