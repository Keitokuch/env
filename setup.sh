#! /bin/sh

ENV=~/env
OMZ=~/.oh-my-zsh
TMP=~/.tmux/plugins

# get zsh
if [ -z "$(which zsh)" ]; then
	sudo apt install zsh
	chsh -s /bin/zsh 
fi 


# get tmux
if [ -z "$(which tmux)" ]; then
	sudo apt install tmux 
fi 

# get oh-my-zsh
if [ ! -d "$OMZ" ]; then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
fi

# get tpm
if [ ! -d "$TMP/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi 

# deploy configs
cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme

cp $ENV/zshrc ~/.zshrc
zsh ~/.zshrc

cp $ENV/vimrc ~/.vimrc

cp $ENV/tmux.conf ~/.tmux.conf 


# sudo chmod +x $ENV/update.sh 

