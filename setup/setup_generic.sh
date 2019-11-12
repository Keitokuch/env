#! /usr/bin/env bash 

OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

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

# get oh-my-zsh
get_OMZ() {
    parse_options $@
    if [[ ! -d $OMZ ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
       [[ $silent ]] ||  MSG+=(">>> installed oh-my-zsh <<<")
    else
       [[ $silent ]] || MSG+=("=== oh-my-zsh already installed ===")
    fi
}

get_vimplug() {
    parse_options $@
    if [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
        [[ $silent ]] || MSG+=(">>> installing vim-plug <<<")
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        [[ $silent ]] || MSG+=("=== vim-plug already installed ===")
    fi 
}


deploy_zsh() {
    MSG+=(">>> deploying zsh configs")
    sudo cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    sudo cp $ENV/zshrc ~/.zshrc
}

deploy_tmux() {
    MSG+=(">>> deploying tmux configs")
    tic $ENV/utils/xterm-256color-italic.terminfo 
    sudo cp $ENV/tmux.conf ~/.tmux.conf 
}

deploy_vim() {
    MSG+=(">>> deploying vim configs")
    sudo mkdir -p ~/.config/nvim/
    sudo cp $ENV/vimrc ~/.vimrc
    sudo cp $ENV/init.vim ~/.config/nvim/init.vim 

    # vim colorscheme
    sudo mkdir -p ~/.vim/colors/ 
    sudo mkdir -p ~/.config/nvim/colors/
    sudo cp $ENV/vim-keitoku.vim ~/.vim/colors/ 
    sudo cp $ENV/vim-keitoku.vim ~/.config/nvim/colors/
}

deploy_configs() {
    deploy_zsh
    deploy_tmux
    deploy_vim
}

# print log
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}


get_invalid() {
    echo "$1: setup for $OS not implemented."
}
get_curl() {
    get_invalid ${FUNCNAME[0]}
}
get_zsh() {
    get_invalid ${FUNCNAME[0]}
}
get_nvim() {
    get_invalid ${FUNCNAME[0]}
}
get_nodejs() {
    get_invalid ${FUNCNAME[0]}
}
get_tmux() {
    get_invalid ${FUNCNAME[0]}
}
get_python3() {
    get_invalid ${FUNCNAME[0]}
}
get_ranger() {
    get_invalid ${FUNCNAME[0]}
}
get_ctags() {
    get_invalid ${FUNCNAME[0]}
}


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

