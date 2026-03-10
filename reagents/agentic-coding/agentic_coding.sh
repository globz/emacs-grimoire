#!/bin/bash

# This is my current agentic coding stack
# opencode - https://github.com/anomalyco/opencode
# nono for kernel-level sandboxing - https://github.com/always-further/nono

# The following scripts tools are an alternative to nono
# landrun for kernel-level sandboxing - https://github.com/Zouuup/landrun
# scoder for sandboxing env - https://github.com/aemonge/aemonge/blob/main/bin/scoder

# Requirements
# Linux kernel 5.13 or later with Landlock enabled
# Linux kernel 6.7 or later for network restrictions (TCP bind/connect)
# Go 1.18 or later (for building landrun from source)

agentic_coding()
{

    local wd=$(pwd)
    local emacs_deps_dir="${wd}/emacs-deps"
    local this_root_path="${wd}/reagents/agentic-coding"
    local opencode_config="${this_root_path}/config/opencode/opencode.json"
    local opencode_skills="${this_root_path}/config/opencode/skills/*"
    local opencode_skills_dest="${HOME}/.config/opencode/skills/"
    local nono_opencode_config="${this_root_path}/config/nono/opencode.json"
    local nono_profiles_dest="${HOME}/.config/nono/profiles/"
    local scoder_path="${wd}/reagents/agentic-coding/scoder"
    local repo_landrun="https://github.com/zouuup/landrun.git"
    local landlock_abi_check_dest="${HOME}/.local/bin/"
    local nono_version="v0.15.0"
    local nono_download_url="https://github.com/always-further/nono/releases/download/${nono_version}/nono-${nono_version}-x86_64-unknown-linux-gnu.tar.gz"
    local nono_binary="nono-${nono_version}-x86_64-unknown-linux-gnu.tar.gz"
    
    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Install opencode (harness)\e[m"
    echo -e "\e[0;35m2 - Install/Update nono (kernel-level sandboxing) - preferred\e[m"
    echo -e "\e[0;35m3 - Install landrun (kernel-level sandboxing) - alternative\e[m"
    echo -e "\e[0;35m4 - Install/Update scoder (opencode sandboxing env) - alternative\e[m"
    echo -e "\e[0;35m5 - Install/Update configuration files (opencode & nono)\e[m"

    read -p 'Choice: ' ACTION
    
    if [[ "$ACTION" == 1 ]]
    then
        echo -e "\e[0;35m Installing opencode...\e[m"
        curl -fsSL https://opencode.ai/install | bash
        sudo cp ~/.opencode/bin/opencode /usr/bin/
        sudo chmod +x /usr/bin/opencode
    fi

    if [[ "$ACTION" == 2 ]]
    then
        echo -e "\e[0;35m Installing nono (kernel-level sandboxing)...\e[m"
        mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && wget "${nono_download_url}"
        tar -xf "${nono_binary}"
        mv nono "${HOME}/.local/bin/"
        echo -e "You may now invoke opencode with nono via: \n"
        echo -e "\e[0;35m nono run -vvv --profile opencode -- opencode \e[m"
    fi

    if [[ "$ACTION" == 3 ]]
    then
        echo -e "\e[0;35m Installing landrun (kernel-level sandboxing)...\e[m"
        mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && git clone "${repo_landrun}"
        cd landrun
        go build -o landrun cmd/landrun/main.go
        sudo cp landrun /usr/local/bin/
    fi

    if [[ "$ACTION" == 4 ]]
    then
        echo -e "\e[0;35m Installing/updating scoder (opencode sandboxing env)...\e[m"
        git pull
        sudo cp "${scoder_path}" /usr/local/bin/
        sudo chmod +x /usr/local/bin/scoder

        # Fallback ABI check for Ubuntu 24.04.4 LTS
        cp "${this_root_path}/landlock_abi_check" "${landlock_abi_check_dest}"
        sudo chmod +x "${landlock_abi_check_dest}/landlock_abi_check"
    fi

    if [[ "$ACTION" == 5 ]]
    then
        echo -e "\e[0;35m Installing/updating configuration files...\e[m"
        git pull

        echo -e "\e[0;35m .config/opencode \e[m"
        cp "${opencode_config}" "${HOME}/.config/opencode/"

        echo -e "\e[0;35m .config/opencode/skills \e[m"
        mkdir -p ${opencode_skills_dest}
        cp -r ${opencode_skills} ${opencode_skills_dest}
                
        echo -e "\e[0;35m .config/nono/profiles \e[m"
        mkdir -p "${nono_profiles_dest}"
        cp "${nono_opencode_config}" "${nono_profiles_dest}"
    fi    
    
}
