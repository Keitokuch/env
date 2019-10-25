#! /usr/bin/env bash 

OS=ubuntu


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

