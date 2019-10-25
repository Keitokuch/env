#! /usr/bin/env bash 

OS=Ubuntu


get_tmux() {
    if [[ ! -x $(command -v tmux) ]] ; then
        sudo apt install libevent-dev
        sudo apt install libncurses-dev
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


get_zsh() {
    if ! [[ -x $(command -v zsh) ]]; then
        sudo apt install zsh
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


get_nvim() {
    if ! [[ -x $(command -v nvim) ]]; then
        sudo apt install neovim
        sudo apt install python-neovim
        sudo apt install python3-neovim
        MSG+=(">>> installed neovim <<<")
    else 
        MSG+=("=== neovim already installed ===")
    fi
}


get_nodejs() {
    if ! [[ -x $(command -v node) ]]; then
        sudo apt install -y nodejs
        MSG+=(">>> installed nodejs <<<")
    else 
        MSG+=("=== nodejs already installed ===")
    fi 
}


get_python3() {
    if ! [[ -x $(command -v python3) ]]; then
        sudo apt install python3
        sudo apt install python3-pip
        MSG+=(">>> installed python3 <<<")
    else
        MSG+=('=== python3 already installed ===')
    fi
}

# deploy configs
deploy_configs() {
    MSG+=(">>> deploying zsh configs")
    sudo cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
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

get_kbuild() {
    sudo apt install build-essential kernel-package libncurses5-dev
    apt install flex bison
    apt install openssl libssl-dev libelf-dev
    MSG+=(">>> installed kernel build dependencies.")
}

