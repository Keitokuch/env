#! /usr/bin/env bash 

OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

declare -a MSG=()


# get oh-my-zsh
get_OMZ() {
    if [[ ! -d $OMZ ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
        MSG+=(">>> installed oh-my-zsh <<<")
    else
        MSG+=("=== oh-my-zsh already installed ===")
    fi
}

get_vimplug() {
    if [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
        MSG+=(">>> installing vim-plug <<<")
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        MSG+=("=== vim-plug already installed ===")
    fi 
}

# deploy configs
deploy_configs() {
    MSG+=(">>> deploying zsh configs")
    cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    cp $ENV/zshrc ~/.zshrc

    MSG+=(">>> deploying tmux configs")
    tic $ENV/utils/xterm-256color-italic.terminfo 
    cp $ENV/tmux.conf ~/.tmux.conf 

    mkdir -p ~/.config/nvim/
    MSG+=(">>> deploying vim configs")
    cp $ENV/vimrc ~/.vimrc
    cp $ENV/init.vim ~/.config/nvim/init.vim 

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp $ENV/vim-keitoku.vim ~/.vim/colors/ 
    cp $ENV/vim-keitoku.vim ~/.config/nvim/colors/
}

# print log
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}

get_curl() {
    echo "get_curl: OS specific install not implemented."
}
get_zsh() {
    echo "get_zsh: OS specific install not implemented."
}
get_nvim() {
    echo "get_nvim: OS specific install not implemented."
}
get_nodejs() {
    echo "get_nodejs: OS specific install not implemented."
}
get_tmux() {
    echo "get_tmux: OS specific install not implemented."
}
get_python3() {
    echo "get_python3: OS specific install not implemented."
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


