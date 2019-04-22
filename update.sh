#! /bin/sh

ENV=~/env
OMZ=~/.oh-my-zsh

zshrc() {
	cp $ENV/zshrc ~/.zshrc
	zsh ~/.zshrc
}

vimrc() {
	cp $ENV/vimrc ~/.vimrc
}

tm() {
	cp $ENV/tmux.conf ~/.tmux.conf
	if [ -n "$TMUX" ]; then
		tmux source-file -q ~/.tmux.conf 
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
			zshrc
			vimrc
			tm 
			zshTheme
			;;
	esac 
done

