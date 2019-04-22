#! /bin/sh

ENV=~/env
OMZ=~/.oh-my-zsh

# get zsh
if [ -z "$(which zsh)" ]; then
	sudo apt install zsh
fi 

chsh -s /bin/zsh 

# get tmux
if [ -z "$(which tmux)"]; then
	sudo apt install tmux 
fi 

# get oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# deploy configs
cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme

cp $ENV/zshrc ~/.zshrc
zsh ~/.zshrc

cp $ENV/vimrc ~/.vimrc

cp $ENV/tmux.conf ~/.tmux.conf 


sudo chmod +x $ENV/update.sh 

