#! /usr/bin/env zsh 

ENV="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
OMZ=~/.oh-my-zsh
DOTFILE=$ENV/dotfiles
THEME=$ENV/themes
UTILS=$ENV/utils

. $UTILS/env_utils.sh

zshrc() {
    cp $DOTFILE/zshrc ~/.zshrc
	source ~/.zshrc
    echo ".zshrc updated"
}

vimrc() {
	if [ -f ./vimrc.local ]; then
		cp ./vimrc.local ~/.vimrc
	else
		cp $DOTFILE/vimrc ~/.vimrc
	fi 
    cp $DOTFILE/init.vim ~/.config/nvim/init.vim 
    echo ".vimrc, init.vim updated"
}

vimTheme() {
    if [ -f ./vim-keitoku.vim.local ]; then
        cp ./vim-keitoku.vim.local ~/.vim/colors/vim-keitoku.vim 
    else 
        cp $THEME/vim-keitoku.vim ~/.vim/colors/ 
        cp $THEME/vim-keitoku.vim ~/.config/nvim/colors/vim-keitoku.vim 
    fi 
    echo "vim colorscheme updated"
}

tm() {
	if [ -f ./tmux.conf.local ]; then
		cp ./tmux.conf.local ~/.tmux.conf
	else
		cp $DOTFILE/tmux.conf ~/.tmux.conf
	fi

    cp $DOTFILE/tmux.remote.conf ~/.tmux/tmux.remote.conf

	if [ -n "$TMUX" ]; then
		tmux source-file ~/.tmux.conf 
	fi
    echo ".tmux.conf tmux.remote.conf updated"
}

zshTheme() {
	cp $THEME/keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
	source ~/.zshrc
    echo "zsh-theme updated"
}

if [ $# -eq 0 ]; then 
    echo "updating all..."
    vimrc
    vimTheme
    tm 
    zshTheme
    zshrc
else
    while getopts ":VzvtZ" opt; do
        case $opt in
            z)
                zshrc
                ;;
            v)
                vimrc
                ;;
            V)
                vimTheme 
                ;; 
            t)
                tm
                ;;
            Z)
                zshTheme
                ;;
        esac 
    done
fi
