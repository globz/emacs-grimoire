ls_ts_reqs()
{

    local version="v18.18.0"
    local check_type=$(type -t nvm)

    if [[ ${check_type} != "function" ]]
    then
        echo -e "\033[31m nvm (Node Version Manager) could not be found\e[m"
        echo -e "\033[31m Node is required for language servers using TypeScript\e[m"
        echo -e "\033[31m nvm is a must to manage all this mess of an ecosystem...enjoy\e[m"
        echo -e "\033[31m Installing nvm and Node ${version}\e[m"

        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash && source ~/.bashrc && nvm install "${version}" && nvm list

        # TODO might be a good idea to set the path? https://unix.stackexchange.com/questions/32041/checking-if-path-contains-home-mydir-and-adding-it-if-not-all-in-a-script
        echo $PATH | grep -q  "${HOME}/.nvm/versions/node/${version}/bin" || echo -e "\033[31m !WARNING! nvm is not in your path.\e[m"
    fi

}
