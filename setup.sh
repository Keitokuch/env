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
cp ./keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme

cp ./zshrc ~/.zshrc
zsh ~/.zshrc

cp ./vimrc ~/.vimrc
mkdir -p ~/.vim/colors/ 
cp ./vim-keitoku.vim ~/.vim/colors/ 

tic ./utils/xterm-256color-italic.terminfo 
cp ./tmux.conf ~/.tmux.conf 



