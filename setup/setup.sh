#! /usr/bin/env bash 

declare -a MSG=()

parse_options() {
    #for var in "$@"
    #do
    #    [[ $var == f ]] && forced=1
    #    [[ $var == s ]] && silent=1
    #    [[ $var == v ]] && ver=1
    #    [[ $ver ]] && VERSION=$var
    #done
    unset silent forced VERSION
    while getopts ":fsv:" opt; do
        case $opt in
            f)
                forced=1
                ;;
            s)
                silent=1
                ;;
            v)
                VERSION=$OPTARG
                ;; 
        esac 
    done
}

# print log
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}

. $SETUP/setup_generic.sh
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VER=$VERSION_ID
        if [[ $OS == "centos" ]]; then
            . $SETUP/setup_centos.sh
        elif [[ $OS == "ubuntu" ]]; then
            . $SETUP/setup_ubuntu.sh
        else
            echo "Failed: linux distro $OS not supported."
            exit 1
        fi
    else
        echo "Failed: linux distro not recognized."
        exit 1
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    . $SETUP/setup_macos.sh
else
    echo "Failed: OS type $OSTYPE not supported."
    exit 1
fi


