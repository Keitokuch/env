#! /usr/bin/env bash 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SETUP=$ENV/setup
THEME=$ENV/themes
DOTFILE=$ENV/dotfiles
SRC=$ENV/src
UTILS=$ENV/utils

. $UTILS/env_utils.sh
. $SETUP/setup.sh

PY_VERSION=3.6.8
TMUX_VERSION=3.0

get_curl
get_zsh
get_python3 
get_tmux   
get_nvim
get_vimplug
get_nodejs
get_OMZ
get_ctags
get_ag

deploy_configs

put_msg
zsh
