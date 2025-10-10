#!/bin/bash

install() {

    local wd=$(pwd)    
    local version="v0.18.0"
    local asdf_output=$(type -p asdf | grep "asdf")

    echo -e "\033[31m Checking if asdf [Runtime Version Manager] is currently installed...\e[m"

    if ! [ $asdf_output ];
    then
        echo -e "\033[31m asdf [Runtime Version Manager] could not be found\e[m"
        echo -e "\033[31m Installing asdf ${version}\e[m"

        local asdf_repo="https://github.com/asdf-vm/asdf/releases/download/${version}/asdf-${version}-linux-amd64.tar.gz"
        local emacs_deps_dir="${wd}/emacs-deps/"

        echo -e "\033[31m Downloading asdf-${version}\e[m"
        mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && wget "${asdf_repo}"

        # https://asdf-vm.com/guide/getting-started.html#_1-install-asdf
        echo -e "\033[31m Install to ~/.local/bin\e[m"
        echo -e "\033[31m If this location is not in your PATH please add it!\e[m"        
        tar -xzf "asdf-${version}-linux-amd64.tar.gz" -C ~/.local/bin/
        rm "asdf-${version}-linux-amd64.tar.gz"
        
        type -a asdf
    fi

    echo -e "\033[31m asdf is already installed...\e[m"
    echo -e "\033[31m Checking if asdf is in PATH\e[m"

   # Check if the export command exists, else append it
   if ! grep -q 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' ~/.bashrc; then
     echo -e "\033[31m asdf shims is NOT present in ~/.bash_profile\e[m"
     echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> ~/.bashrc
   else
     echo -e "\033[31m asdf shims is already present in ~/.bash_profile\e[m"
   fi
    
    # asdf completion
    if ! grep -Fq '. <(asdf completion bash)' ~/.bashrc
    then
        echo -e "\033[31m asdf completion is NOT present in ~/.bashrc\e[m"
        echo ". <(asdf completion bash)" >> ~/.bashrc
    else
        echo -e "\033[31m asdf completion is already present in ~/.bashrc\e[m"
    fi

}
