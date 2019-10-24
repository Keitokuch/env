#! /usr/bin/env bash 

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
        if [[ $OS == "centos" ]]; then
            . ./setup_centos.sh
        elif [[ $OS == "ubuntu" ]]; then
            echo "TODO: ubuntu script"
        else
            echo "Failed: linux distro $OS not supported."
        fi
    else
        echo "Failed: linux distro not recognized."
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "TODO: macos script"
else
    echo "Failed: OS type $OSTYPE not supported."
fi


get_curl
get_zsh
get_python3
get_tmux
get_nvim
get_vimplug
get_nodejs
get_OMZ

deploy_configs

put_msg
zsh
