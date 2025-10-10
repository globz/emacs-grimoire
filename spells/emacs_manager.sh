#!/bin/bash

download_src()
{

    local wd=$(pwd)
    local version=$1

    echo -e "\033[31m Default version is currently set to ${version}.\e[m"
    echo -e "\033[31m Would you like to input another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        version=$USER_VERSION
    fi

    local emacs_src_dir="${wd}/emacs-src"
    local emacs_src_url="http://ftp.gnu.org/gnu/emacs/emacs-${version}.tar.xz"

    echo -e "\033[31m Downloading emacs-${version}.tar.xz\e[m"
    mkdir -p "${emacs_src_dir}" && cd "${emacs_src_dir}" && wget "${emacs_src_url}"

    if ! command -v tar &> /dev/null
    then
        echo -e "\033[31m <tar> could not be found\e[m"
        echo -e "\033[31m Installing xz-utils...\e[m"
        sudo apt install xz-utils
    fi

    echo -e "\033[31m Exracting emacs-${version}.tar.xz\e[m"
    tar -xf "emacs-${version}.tar.xz"
    mv "emacs-${version}.tar.xz" "emacs-${version}"

    echo -e "\033[31m Done.\e[m"
}

build_src()
{

    local wd=$(pwd)
    local version=$1

    echo -e "\033[31m Default build version is currently set to ${version}\e[m"

    echo -e "\033[31m Would you like to input another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        version=$USER_VERSION
    fi

    local emacs_src_dir="${wd}/emacs-src"

    case "${version}" in

        "29.4")
            parent_function=build_29_4
            ;;
        
        "29.1")
            parent_function=build_29_1
            ;;

        "28.2")
            parent_function=build_28_2
            ;;

        *)
            echo -e "\033[31mNo build instruction found for emacs-${version} - Aborting.\e[m"
            return 1
            ;;
    esac

    $parent_function $emacs_src_dir $version

}

build_29_4()
{

    local emacs_src_dir=$1
    local version=$2
    
    if [[ "${version}" == "29.4" ]]
    then
        echo -e "\033[31m Installing build dependencies...\e[m"
        sudo sed -i '/deb-src/s/^# //' /etc/apt/sources.list && sudo apt update
        sudo apt build-dep -y emacs
        sudo apt install libgccjit0 libgccjit-11-dev libjansson4 libjansson-dev \
             gnutls-bin gcc-11 libtiff5-dev libgif-dev libjpeg-dev \
             libpng-dev libwebp-dev webp libxft-dev libxft2 libgtk-3-dev libncurses-dev \
             texinfo libgnutls28-dev libxpm-dev

        echo -e "\033[31m Configuring and building Emacs ${version}...\e[m"
        cd "${emacs_src_dir}/emacs-${version}/"
        export CC=/usr/bin/gcc-11 && export CXX=/usr/bin/gcc-11 && export LD_LIBRARY_PATH=/usr/local/lib/
        ./autogen.sh
        ./configure --with-native-compilation=aot --with-json \
        --with-tree-sitter --with-pgtk
        make -j$(nproc)

        echo -e "\033[31m Build complete, you may test this build within this directory ${emacs_src_dir}/emacs-${version}/ with ./src/emacs -Q\e[m"
    fi

}

build_29_1()
{

    local emacs_src_dir=$1
    local version=$2

    if [[ "${version}" == "29.1" ]]
    then
        echo -e "\033[31m Installing build dependencies...\e[m"
        sudo sed -i '/deb-src/s/^# //' /etc/apt/sources.list && sudo apt update
        sudo apt build-dep -y emacs
        sudo apt install libgccjit0 libgccjit-11-dev libjansson4 libjansson-dev \
             gnutls-bin libtree-sitter-dev gcc-11 imagemagick libmagick++-dev \
             libwebp-dev webp libxft-dev libxft2

        echo -e "\033[31m Configuring and building Emacs ${version}...\e[m"
        cd "${emacs_src_dir}/emacs-${version}/"
        export CC=/usr/bin/gcc-11 && export CXX=/usr/bin/gcc-11
        ./autogen.sh
        ./configure --with-native-compilation=aot --with-json --with-tree-sitter
        make -j$(nproc)

        echo -e "\033[31m Build complete, you may test this build within this directory ${emacs_src_dir}/emacs-${version}/ with ./src/emacs -Q\e[m"
    fi

}

build_28_2()
{

    local emacs_src_dir=$1
    local version=$2

    if [[ "${version}" == "28.2" ]]
    then
        echo -e "\033[31m Installing build dependencies...\e[m"
        sudo apt build-dep -y emacs
        sudo apt install libgccjit0 libgccjit-11-dev libjansson4 libjansson-dev

        echo -e "\033[31m Configuring and building Emacs ${version}...\e[m"
        cd "${emacs_src_dir}/emacs-${version}/"
        export CC=/usr/bin/gcc-11 && export CXX=/usr/bin/gcc-11
        ./autogen.sh
        ./configure --with-native-compilation
        make -j$(nproc)

        echo -e "\033[31m Build complete, you may test this build within this directory ${emacs_src_dir}/emacs-${version}/ with ./src/emacs -Q\e[m"
    fi

}

install_src()
{

    local wd=$(pwd)
    local version=$1
    local emacs_src_dir="${wd}/emacs-src"

    echo -e "\033[31m Default install version is currently set to ${version}\e[m"
    echo -e "\033[31m The following version are available for installation...\e[m"
    cd "${emacs_src_dir}" && ls -d emacs-* | grep -o "[0-9].*"

    echo -e "\033[31m Would you like to install another version?\e[m"
    read -p 'Use another version (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        read -p 'Version: ' USER_VERSION
        version=$USER_VERSION
    fi

    local emacs_install_dir="${wd}/emacs-src/emacs-${version}/"

    cd "${emacs_install_dir}" && export LD_LIBRARY_PATH=/usr/local/lib/ && sudo make install

}

uninstall_src()
{

    local wd=$(pwd)
    local emacs_src_dir="${wd}/emacs-src"

    echo -e "\033[31m Please select a version to uninstall from the list below...\e[m"
    cd "${emacs_src_dir}" && ls -d emacs-* | grep -o "[0-9].*"

    read -p 'Version: ' UNINSTALL_THIS_VERSION

    cd "${emacs_src_dir}/emacs-${UNINSTALL_THIS_VERSION}" && sudo make uninstall

}
