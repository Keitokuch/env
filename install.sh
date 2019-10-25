#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
. $SETUP/setup_generic.sh


PY_VERSION=3.7.4
TMUX_VERSION=2.9a

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
