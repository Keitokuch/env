#! /bin/sh

ENV=~/env

if [ -z "$(which zsh)"]; then
	sudo apt install zsh
fi 

chsh -s /bin/zsh 

if [ -z "$(which tmux)"]; then
	sudo apt install tmux 
fi 

cp $ENV/zshrc ~/.zshrc
zsh ~/.zshrc

cp $ENV/vimrc ~/.vimrc

cp $ENV/tmux.conf ~/.tmux.conf 

sudo chmod +x $ENV/update.sh 

