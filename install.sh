#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
. $SETUP/setup_generic.sh


PY_VERSION=3.6.8
TMUX_VERSION=2.9a

get_curl
get_zsh -s
get_python3 -s
get_tmux -s
get_nvim
get_vimplug
get_nodejs
get_OMZ -s

deploy_configs

put_msg
zsh