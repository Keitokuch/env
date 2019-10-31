#! /usr/bin/env bash 

OS=Ubuntu


get_tmux() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v tmux) ]] ; then
        sudo apt install libevent-dev
        sudo apt install libncurses-dev
        wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
        tar -xvf tmux-${TMUX_VERSION}.tar.gz
        cd tmux-${TMUX_VERSION}
        ./configure && make
        sudo make install
        cd $ENV && rm -rf tmux-${TMUX_VERSION}
        rm tmux-${TMUX_VERSION}.tar.gz
        [[ $silent ]] || MSG+=(">>> installed tmux <<<")
    else
        [[ $silent ]] || MSG+=("=== tmux already installed ===")
    fi 
    # get tpm
    if [[ ! -d "$TMP/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
    fi
}


get_zsh() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v zsh) ]]; then
        sudo apt install zsh
        if [[ -x "/bin/zsh" ]]; then
            chsh -s "/bin/zsh"
        else 
            chsh -s $(which zsh) 
        fi
        [[ $silent ]] || MSG+=(">>> installed zsh <<<")
    else
        [[ $silent ]] || MSG+=("=== zsh already installed ===")
    fi 
}


get_nvim() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v nvim) ]]; then
        sudo apt install neovim
        sudo apt install python-neovim
        sudo apt install python3-neovim
        [[ $silent ]] || MSG+=(">>> installed neovim <<<")
    else 
        [[ $silent ]] || MSG+=("=== neovim already installed ===")
    fi
}


get_nodejs() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v node) ]]; then
        curl -sL install-node.now.sh/lts | sudo bash
        [[ $silent ]] || MSG+=(">>> installed nodejs <<<")
    else 
        [[ $silent ]] || MSG+=("=== nodejs already installed ===")
    fi 
}


get_python3() {
    parse_options $@
    if [[ $forced ]] || ! [[ -x $(command -v python3) ]]; then
        sudo apt install python3
        sudo apt install python3-pip
        [[ $silent ]] || MSG+=(">>> installed python3 <<<")
    else
        [[ $silent ]] || MSG+=('=== python3 already installed ===')
    fi
}

deploy_zsh() {
    MSG+=(">>> deploying zsh configs")
    sudo cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    cp $ENV/zshrc ~/.zshrc
    cp $ENV/zshrc.ubuntu ~/.zshrc.native
}

get_kbuild() {
    sudo apt install build-essential kernel-package libncurses5-dev
    apt install flex bison
    apt install openssl libssl-dev libelf-dev
    MSG+=(">>> installed kernel build dependencies.")
}

get_ranger() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v ranger) ]]; then
        sudo apt install ranger
        [[ $silent ]] || MSG+=(">>> installed ranger <<<")
    else
        [[ $silent ]] || MSG+=('=== ranger already installed ===')
    fi
}

get_ctags() {
    parse_options $@
    if [[ $forced ]] || [[ ! -x $(command -v ctags) ]]; then
        src=$SRC/ctags
        sudo apt install \
            gcc make pkg-config autoconf automake \
            python3-docutils libseccomp-dev libjansson-dev \
            libyaml-dev libxml2-dev
        git clone https://github.com/universal-ctags/ctags.git $src
        cd $src
        ./autogen.sh
        ./configure && make
        sudo make install
        cd $ENV
        [[ $silent ]] || MSG+=(">>> installed ctags <<<")
    else
        [[ $silent ]] || MSG+=('=== ctags already installed ===')
    fi
}
