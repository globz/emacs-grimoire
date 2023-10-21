#!/bin/bash

validate_env() {

    # define your host environment
    local valid_env=("LINUX")
    local wd=$(pwd)
    local env=$1
    local os_name=$(uname)
    
    # =spellpouch=
    source "${wd}/spells/spellpouch.sh"
    
    if ! spellpouch -p "elementIn" -e "${env}" "${valid_env[@]}"
    then
        echo -e "\033[33mInvalid ENV :\e[0m expected values are one of the following : ${valid_env[@]}"
        exit 1
    elif [ "$env" == "LINUX" ] && [ "$os_name" != "Linux" ]
    then
        echo -e "\033[33mInvalid OS for ENV : $env\e[0m - expected OS [LINUX]"
        exit 1
    fi

}
