#!/bin/bash

install() {

local version="v0.13.1"
#local check_type=$(type -t asdf)

echo -e "\033[31m Checking if asdf [Runtime Version Manager] is currently installed...\e[m"

if ! [ -x "$(command -v asdf)" ]
then
    echo -e "\033[31m asdf [Runtime Version Manager] could not be found\e[m"
    echo -e "\033[31m Installing asdf ${version}\e[m"

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch "${version}"

    # asdf path
    if ! grep -Fq '. "$HOME/.asdf/asdf.sh"' ~/.bashrc
    then
        cat<<"EOF" >> ~/.bashrc
. "$HOME/.asdf/asdf.sh"
EOF
    else
        echo "asdf path is already present in ~/.bashrc"
    fi

    # bash_completion
    if ! grep -Fq '. "$HOME/.asdf/completions/asdf.bash"' ~/.bashrc
    then
        cat<<"EOF" >> ~/.bashrc
. "$HOME/.asdf/completions/asdf.bash"
EOF
    else
        echo "bash_completion for asdf is already present in ~/.bashrc"
    fi

    echo -e "\n Restart your terminal so that PATH changes take effect."
    return 1

fi

}
