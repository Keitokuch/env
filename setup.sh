#! /bin/sh

OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

# get zsh
if ! [ -x "$(command -v zsh)" ]; then
	sudo apt install zsh
	chsh -s $(which zsh) 
fi 


# get tmux
if ! [ -x "$(command -v tmux)" ]; then
	sudo apt install tmux 
fi 

# get oh-my-zsh
if [ ! -d "$OMZ" ]; then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

# get tpm
if [ ! -d "$TMP/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi 

# deploy configs
echo "setting zsh configs"
cp ./keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme

cp ./zshrc ~/.zshrc
zsh ~/.zshrc

echo "setting vim configs"
cp ./vimrc ~/.vimrc
# Vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# vim colorscheme
mkdir -p ~/.vim/colors/ 
mkdir -p ~/.config/nvim/
cp ./vim-keitoku.vim ~/.vim/colors/ 
# install nodejs for coc.nvim
#curl -sL install-node.now.sh/lts | bash
sudo apt-get install -y nodejs
echo "setting tmux configs"
tic ./utils/xterm-256color-italic.terminfo 
cp ./tmux.conf ~/.tmux.conf 

sudo apt install neovim 

sudo apt install universal-ctags
