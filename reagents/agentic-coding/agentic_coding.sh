#!/bin/bash

# This is my current agentic coding stack
# opencode - https://github.com/anomalyco/opencode
# non for kernel-level sandboxing - https://github.com/always-further/nono

# The following scripts tools are an alternative to nono
# landrun for kernel-level sandboxing - https://github.com/Zouuup/landrun
# scoder for sandboxing env - https://github.com/aemonge/aemonge/blob/main/bin/scoder

# Requirements
# Linux kernel 5.13 or later with Landlock enabled
# Linux kernel 6.7 or later for network restrictions (TCP bind/connect)
# Go 1.18 or later (for building from source)

agentic_coding()
{

    local env=$1
    local wd=$(pwd)
    local emacs_deps_dir="${wd}/emacs-deps"
    local agentic_coding_path="${wd}/reagents/agentic-coding"
    local scoder_path="${wd}/reagents/agentic-coding/scoder"
    local repo_landrun="https://github.com/zouuup/landrun.git"
    local LANDLOCK_ABI_CHECK_DEST="${HOME}/.local/bin/"
    local NONO_VERSION="v0.7.0"
    local NONO_DOWNLOAD_URL="https://github.com/always-further/nono/releases/download/${NONO_VERSION}/nono-${NONO_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    local NONO_BINARY="nono-${NONO_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
    
    # Sourcing spellpouch from working directory (user grimoire)
    source "${wd}/spells/spellpouch.sh"

    echo "The following options are available, please make a choice ::"
    echo -e "\e[0;35m1 - Install opencode (harness)\e[m"
    echo -e "\e[0;35m2 - Install nono (kernel-level sandboxing)\e[m"
    echo -e "\e[0;35m3 - Install landrun (kernel-level sandboxing)\e[m"
    echo -e "\e[0;35m4 - Install/Update scoder (opencode sandboxing env)\e[m"
    echo -e "\e[0;35m5 - Install/Update opencode.json config\e[m"

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
        mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && wget "${NONO_DOWNLOAD_URL}"
        tar -xf "${NONO_BINARY}"
        mv nono "${HOME}/.local/bin/"
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
        cp "${agentic_coding_path}/landlock_abi_check" "${LANDLOCK_ABI_CHECK_DEST}"
        sudo chmod +x "${LANDLOCK_ABI_CHECK_DEST}/landlock_abi_check"
    fi

    if [[ "$ACTION" == 5 ]]
    then
        echo -e "\e[0;35m Installing/update opencode.json config...\e[m"
        git pull
        cp "${agentic_coding_path}/opencode.json" "${HOME}/.config/opencode/"
    fi    
    
}
