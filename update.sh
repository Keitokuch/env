#! /bin/sh

ENV=~/env
OMZ=~/.oh-my-zsh

zshrc() {
	if [ -f $ENV/zshrc.local ]; then
		cp $ENV/zshrc.local ~/.zshrc
	else
		cp $ENV/zshrc ~/.zshrc
	fi
	zsh ~/.zshrc
}

vimrc() {
	if [ -f $ENV/vimrc.local ]; then
		cp $ENV/vimrc.local ~/.vimrc
	else
		cp $ENV/vimrc ~/.vimrc
	fi 
}

tm() {
	if [ -f $ENV/tmux.conf.local ]; then
		cp $ENV/tmux.conf.local ~/.tmux.conf
	else
		cp $ENV/tmux.conf ~/.tmux.conf
	fi

	if [ -n "$TMUX" ]; then
		tmux source-file ~/.tmux.conf 
	fi
}

zshTheme() {
	cp $ENV/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
	zsh ~/.zshrc
}


while getopts ":azvtZ" opt; do
	case $opt in
		z)
			zshrc
			echo "updated .zshrc"
			;;
		v)
			vimrc
			echo "updated .vimrc"
			;;
		t)
			tm
			echo "updated .tmux.conf"
			;;
		Z)
			zshTheme
			echo "updated zsh-theme"
			;;
		a)
			echo "updating all"
			vimrc
			tm 
			zshTheme
			zshrc
			;;
	esac 
done

