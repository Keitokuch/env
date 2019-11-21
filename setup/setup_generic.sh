#! /usr/bin/env bash 

OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins


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
    cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
    cp $ENV/zshrc ~/.zshrc
}

deploy_tmux() {
    MSG+=(">>> deploying tmux configs")
    tic $ENV/utils/xterm-256color-italic.terminfo 
    cp $ENV/tmux.conf ~/.tmux.conf 
}

deploy_vim() {
    MSG+=(">>> deploying vim configs")
    mkdir -p ~/.config/nvim/
    sudo cp $ENV/vimrc ~/.vimrc
    sudo cp $ENV/init.vim ~/.config/nvim/init.vim 

    # vim colorscheme
    mkdir -p ~/.vim/colors/ 
    mkdir -p ~/.config/nvim/colors/
    cp $ENV/vim-keitoku.vim ~/.vim/colors/ 
    cp $ENV/vim-keitoku.vim ~/.config/nvim/colors/
}

deploy_configs() {
    deploy_zsh
    deploy_tmux
    deploy_vim
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
get_ag() {
    get_invalid ${FUNCNAME[0]}
}

