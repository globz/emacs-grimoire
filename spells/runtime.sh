#!/bin/bash

erlang_elixir() {

    local erlang_version=$1
    local elixir_version=$2

    # Erlang
    echo -e "\n Adding Erlang asdf plugin...\n"
    asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git
    sudo apt-get -y install build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libwxgtk-webview3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk
    asdf list-all erlang
    asdf install erlang "${erlang_version}"

    # Elixir
    echo -e "\n Adding Elixir asdf plugin...\n"
    asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git
    asdf list-all elixir
    asdf install elixir "${elixir_version}"

    # Set default global version
    asdf global erlang 26.1.1
    asdf global elixir 1.15.6-otp-26

}

chez_scheme() {
    local chez_version=$1

    # Chez Scheme
    echo -e "\n Adding chez-scheme asdf plugin...\n"
    asdf plugin add chezscheme
    asdf list-all chezscheme

    asdf install chezscheme "${chez_version}"

    asdf global chezscheme "${chez_version}"

}

mit_scheme_download() {

    local wd=$(pwd)
    local mit_version=$1
    local emacs_deps_dir="${wd}/emacs-deps"

    echo -e "\033[31m Default version is currently set to ${mit_version}.\e[m"
    echo -e "\033[31m Would you like to input another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        mit_version=$USER_VERSION
    fi

    local mit_scheme_src_url="https://ftp.gnu.org/gnu/mit-scheme/stable.pkg/${mit_version}/mit-scheme-${mit_version}-x86-64.tar.gz"

    echo -e "\033[31m Downloading mit-scheme-${mit_version}-x86-64.tar.gz\e[m"
    mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && wget "${mit_scheme_src_url}"

    if ! command -v tar &> /dev/null
    then
        echo -e "\033[31m <tar> could not be found\e[m"
        echo -e "\033[31m Installing xz-utils...\e[m"
        sudo apt install xz-utils
    fi

    echo -e "\033[31m Exracting mit-scheme-${mit_version}-x86-64.tar.gz\e[m"
    tar -xf "mit-scheme-${mit_version}-x86-64.tar.gz"
    mv "mit-scheme-${mit_version}-x86-64.tar.gz" "mit-scheme-${mit_version}"

    echo -e "\033[31m Done.\e[m"

}

mit_scheme_build() {

    local wd=$(pwd)
    local mit_version=$1
    local emacs_deps_dir="${wd}/emacs-deps"

    echo -e "\033[31m Default build version is currently set to ${mit_version}\e[m"

    echo -e "\033[31m Would you like to input another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        mit_version=$USER_VERSION
    fi

    echo -e "\033[31m Configuring and building mit-scheme ${mit_version}...\e[m"
    cd "${emacs_deps_dir}/mit-scheme-${mit_version}/src"
    ./configure
    make

    echo -e "\033[31m Build complete!\e[m"

}

mit_scheme_install() {

    local wd=$(pwd)
    local mit_version=$1
    local emacs_deps_dir="${wd}/emacs-deps"

    echo -e "\033[31m Default install version is currently set to ${mit_version}\e[m"
    echo -e "\033[31m The following version are available for installation...\e[m"
    cd "${emacs_deps_dir}" && ls -d mit-scheme-* | grep -o "[0-9].*"

    echo -e "\033[31m Would you like to install another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        mit_version=$USER_VERSION
    fi

    local mit_scheme_install_dir="${emacs_deps_dir}/mit-scheme-${mit_version}/src"

    cd "${mit_scheme_install_dir}" && sudo make install

}

mit_scheme_uninstall() {

    local wd=$(pwd)
    local emacs_deps_dir="${wd}/emacs-deps"

    echo -e "\033[31m Please select a version to uninstall from the list below...\e[m"
    cd "${emacs_deps_dir}" && ls -d mit-scheme-* | grep -o "[0-9].*"

    read -p 'Version: ' UNINSTALL_THIS_VERSION

    cd "${emacs_deps_dir}/mit-scheme-${UNINSTALL_THIS_VERSION}/src" && sudo make uninstall
}
