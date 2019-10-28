#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
SRC=$ENV/src
. $SETUP/setup_generic.sh


PY_VERSION=3.6.8
TMUX_VERSION=2.9a

get_curl
get_zsh
get_python3 
get_tmux 
get_nvim
get_vimplug
get_nodejs
get_OMZ
get_ctags

deploy_configs

put_msg
zsh
