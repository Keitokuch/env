#! /usr/bin/env bash 

ENV=$PWD
OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

PY_VERSION=3.7.4

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
       echo ">>> installed python3 <<<"
    else
        echo "=== python3 already installed ==="
    fi
}

get_tmux29() {
    if [[ ! -x $(command -v tmux) ]] ; then
        sudo yum install libevent-devel
        sudo yum install ncurses-devel
        wget https://github.com/tmux/tmux/releases/download/2.9a/tmux-2.9a.tar.gz
        tar -xvf tmux-2.9a.tar.gz
        cd tmux-2.9a
        ./configure && make
        sudo make install
        cd $ENV && rm -rf tmux-2.9a
        rm tmux-2.9a.tar.gz
        echo ">>> installed tmux <<<"
    else
        echo "=== tmux already installed ==="
    fi 
}

# get zsh
if ! [[ -x $(command -v zsh) ]]; then
	sudo yum install zsh
    if [[ -x "/bin/zsh" ]]; then
        chsh -s "/bin/zsh"
    else 
        chsh -s $(which zsh) 
    fi
    echo ">>> installed zsh <<<"
else
    echo "=== zsh already installed ==="
fi 

# get tmux
#if ! [[ -x $(command -v tmux) ]]; then
#	sudo yum install tmux 
#    echo ">>> installed tmux <<<"
#else
#    echo "=== tmux already installed ==="
#fi 

# get curl
if ! [[ -x $(command -v curl) ]]; then
	sudo yum install curl 
    echo ">>> installed curl <<<"
else
    echo "=== curl already installed ==="
fi 

# install nodejs for coc.nvim
#curl -sL install-node.now.sh/lts | bash
if ! [[ -x $(command -v node) ]]; then
    sudo curl -sL https://rpm.nodesource.com/setup_12.x | bash -
    echo ">>> installed nodejs <<<"
else 
    echo "=== nodejs already installed ==="
fi 

if ! [[ -x $(command -v nvim) ]]; then
    sudo yum install neovim 
    echo ">>> installed neovim"
else 
    echo "=== neovim already installed ==="
fi


# Vim plug       
if [[ ! -f  ~/.local/share/nvim/site/autoload/plug.vim ]]; then 
    echo ">>> installing vim-plug <<<"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "=== vim-plug already installed ==="
fi 

# get tpm
if [[ ! -d "$TMP/tpm" ]]; then
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

get_python3
get_tmux29

# deploy configs
echo ">>> setting zsh configs"
cp ./keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme

cp ./zshrc ~/.zshrc
zsh ~/.zshrc

echo ">>> setting tmux configs"
tic ./utils/xterm-256color-italic.terminfo 
cp ./tmux.conf ~/.tmux.conf 

mkdir -p ~/.config/nvim/
echo ">>> setting vim configs"
cp ./vimrc ~/.vimrc
cp ./init.vim ~/.config/nvim/init.vim 


# vim colorscheme
mkdir -p ~/.vim/colors/ 
mkdir -p ~/.config/nvim/colors/
cp ./vim-keitoku.vim ~/.vim/colors/ 
cp ./vim-keitoku.vim ~/.config/nvim/colors/

# get oh-my-zsh
if [[ ! -d $OMZ ]]; then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo ">>> installed oh-my-zsh <<<"
else
    echo "=== oh-my-zsh already installed ==="
fi

