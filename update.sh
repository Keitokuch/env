#! /bin/sh

ENV=~/env

zshrc() {
	cp $ENV/zshrc ~/.zshrc
	zsh ~/.zshrc
}

vimrc() {
	cp $ENV/vimrc ~/.vimrc
}

tm() {
	cp $ENV/tmux.conf ~/.tmux.conf
	if [ -n "$TMUX"]; then
		tmux source-file -q ~/.tmux.conf 
	fi
}

while getopts ":azvt" opt; do
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
		a)
			echo "updating all"
			zshrc
			vimrc
			tm 
			;;
	esac 
done

