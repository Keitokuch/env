#! /usr/bin/env bash 

ENV=$PWD
OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

declare -a MSG=()

PY_VERSION=3.7.4
TMUX_VERSION=2.9a


get_python3() {
    if ! [[ -x $(command -v python3) ]]; then
        sudo yum install yum-utils
        sudo yum-builddep python
        curl -O https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tar.xz
        tar xf Python-${PY_VERSION}.tar.xz
        cd Python-${PY_VERSION}
        ./configure && make
        sudo make install
        cd $ENV
        rm -rf Python-${PY_VERSION}
        rm Python-${PY_VERSION}.tar.xz
        MSG+=(">>> installed python3 <<<")
    else
        MSG+=('=== python3 already installed ===')
    fi
}


get_tmux() {
    if [[ ! -x $(command -v tmux) ]] ; then
        sudo yum install libevent-devel
        sudo yum install ncurses-devel
        wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
        tar -xvf tmux-${TMUX_VERSION}.tar.gz
        cd tmux-${TMUX_VERSION}
        ./configure && make
        sudo make install
        cd $ENV && rm -rf tmux-${TMUX_VERSION}
        rm tmux-${TMUX_VERSION}.tar.gz
        MSG+=(">>> installed tmux <<<")
    else
        MSG+=("=== tmux already installed ===")
    fi 
    # get tpm
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi
}


get_nvim() {
    if ! [[ -x $(command -v nvim) ]]; then
        sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        sudo yum install -y neovim python3-neovim
        MSG+=(">>> installed neovim <<<")
    else 
        MSG+=("=== neovim already installed ===")
    fi
}


get_nodejs() {
    if ! [[ -x $(command -v node) ]]; then
        yum install -y gcc-c++ make
        curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
        MSG+=(">>> installed nodejs <<<")
    else 
        MSG+=("=== nodejs already installed ===")
    fi 
}


get_zsh() {
    if ! [[ -x $(command -v zsh) ]]; then
        sudo yum install zsh
        if [[ -x "/bin/zsh" ]]; then
            chsh -s "/bin/zsh"
        else 
            chsh -s $(which zsh) 
        fi
        MSG+=(">>> installed zsh <<<")
    else
        MSG+=("=== zsh already installed ===")
    fi 
}


get_curl() {
    if ! [[ -x $(command -v curl) ]]; then
        sudo yum install curl 
        MSG+=(">>> installed curl <<<")
    else
        MSG+=("=== curl already installed ===")
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
    cp ./keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    cp ./zshrc ~/.zshrc

    MSG+=(">>> deploying tmux configs")
    tic ./utils/xterm-256color-italic.terminfo 
    cp ./tmux.conf ~/.tmux.conf 

    mkdir -p ~/.config/nvim/
    MSG+=(">>> deploying vim configs")
    cp ./vimrc ~/.vimrc
    cp ./init.vim ~/.config/nvim/init.vim 

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp ./vim-keitoku.vim ~/.vim/colors/ 
    cp ./vim-keitoku.vim ~/.config/nvim/colors/
}


# get oh-my-zsh
get_OMZ() {
    if [[ ! -d $OMZ ]]; then
        sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -) --unattended" 
        MSG+=(">>> installed oh-my-zsh <<<")
    else
        MSG+=("=== oh-my-zsh already installed ===")
    fi
}

# print log
put_msg() {
    for msg in "${MSG[@]}"; do
        echo $msg
    done
}
