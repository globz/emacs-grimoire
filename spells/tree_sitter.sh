#!/bin/bash

# Emacs 29.4 and tree-sitter is a brittle relationship, I used to
# rely on libtree-sitter-dev ubuntu package but if it does update or fall
# behind, it will no longer work with the updated language-grammar, therefor
# its best to build it manually from source. However it is foolish to pull
# directly from the main branch, last I tried the main branch was using
# version 0.26 and Emacs would refuse to compile because it broke the
# ABI.

# Instead rely on the releases version. 0.25.10 is working with
# Emacs 29.4 so lets use this one for now. In the future if you update
# your language-grammar or language-server it may break again so you have to
# find a new tree-sitter version which is compatible with both Emacs
# and your language-server/grammar then uninstall and rebuild Emacs.

# If you need to update/re-build tree-sitter do the following:
# Update tree-sitter version in find_tree_sitter_version()
# Uninstall tree-sitter via witchesbrew mix make-emacs -e LINUX
# Uninstall and rebuild emacs via witchesbrew mix make-emacs (This is normally mandatory to resolve ABI incompatibility)

find_tree_sitter_version()
{

    local emacs_version=$1
    local tree_sitter_version=""

    case "${emacs_version}" in

        "29.4")
            tree_sitter_version="0.25.10"
            ;;
        
        "29.1")
            tree_sitter_version="N/A"
            ;;

        "28.2")
            tree_sitter_version="N/A"
            ;;

        *)
            tree_sitter_version="N/A"
            ;;
    esac

    echo $tree_sitter_version

}

find_lib_version()
{
    
   local tree_sitter_version=$1
   echo $(echo "$tree_sitter_version" | cut -d '.' -f 2) # 0.25.10 => 25

}

check_before_build()
{

    local emacs_version=$1
    local tree_sitter_version=$(find_tree_sitter_version $emacs_version)

    # Abort we do not know which version to use...
    if [[ "${tree_sitter_version}" == "N/A" ]]
    then        
        echo -e "\033[31mNo tree-sitter version found for emacs-${emacs_version} - Aborting.\e[m"
        exit 0
    fi

    lib_version=$(find_lib_version $tree_sitter_version)

    if [[ -f "/usr/local/lib/libtree-sitter.so.0.${lib_version}" ]]
    then
        echo -e "\033[31m tree-sitter-${tree_sitter_version} is already installed for Emacs ${emacs_version}\e[m"
    else
        build_src $tree_sitter_version
    fi
}

build_src()
{

    local wd=$(pwd)
    local tree_sitter_version=$1    
    local emacs_deps_dir="${wd}/emacs-deps"
    local tree_sitter_src_url="https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v${tree_sitter_version}.tar.gz"
    local tree_sitter_src_dir="tree-sitter-${tree_sitter_version}"

    echo -e "\033[31m Installing build-essential...\e[m"
    sudo apt update
    sudo apt install build-essential
    
    echo -e "\033[31m Building tree-sitter ${tree_sitter_version}...\e[m"
    mkdir -p "${emacs_deps_dir}" && cd "${emacs_deps_dir}" && wget "${tree_sitter_src_url}" && tar -xf "v${tree_sitter_version}.tar.gz"
    mv "v${tree_sitter_version}.tar.gz" "${tree_sitter_src_dir}"
    cd "${tree_sitter_src_dir}" && make && sudo make install
    echo -e "\033[31m Updated ld cache...\e[m"
    sudo ldconfig

}

make_uninstall()
{
    
    local wd=$(pwd)
    local emacs_deps_dir="${wd}/emacs-deps"

    echo -e "\033[31m Please select a version to uninstall from the list below...\e[m"
    cd "${emacs_deps_dir}" && ls -d tree-sitter-* | grep -o "[0-9].*"

    read -p 'Version: ' UNINSTALL_THIS_VERSION
    
    echo -e "\033[31m Uninstalling tree-sitter-${UNINSTALL_THIS_VERSION}...\e[m"    
    cd "${emacs_deps_dir}/tree-sitter-${UNINSTALL_THIS_VERSION}"
    sudo make uninstall
    cd "${emacs_deps_dir}"

    echo -e "\033[31m Would you like to permanently remove tree-sitter-${UNINSTALL_THIS_VERSION} source files & folder?\e[m"
    read -p 'Delete source files & folder (y/n): ' CHOICE_USER_VERSION

    if [[ "$CHOICE_USER_VERSION" == "y" ]]
    then
        echo -e "\033[31m Removing tree-sitter-${UNINSTALL_THIS_VERSION} from emacs-deps...\e[m"            
        rm -rf "tree-sitter-${UNINSTALL_THIS_VERSION}/"
    fi

}
