#! /usr/bin/env zsh 
OMZ=~/.oh-my-zsh

zshrc() {
	if [ -f ./zshrc.local ]; then
		cp ./zshrc.local ~/.zshrc
	else
		cp ./zshrc ~/.zshrc
	fi
	source ~/.zshrc
    echo ".zshrc updated"

}

vimrc() {
	if [ -f ./vimrc.local ]; then
		cp ./vimrc.local ~/.vimrc
	else
		cp ./vimrc ~/.vimrc
	fi 
    cp ./init.vim ~/.config/nvim/init.vim 
    echo ".vimrc, init.vim updated"
}

vimTheme() {
    if [ -f ./vim-keitoku.vim.local ]; then
        cp ./vim-keitoku.vim.local ~/.vim/colors/vim-keitoku.vim 
    else 
        cp ./vim-keitoku.vim ~/.vim/colors/ 
        cp ./vim-keitoku.vim ~/.config/nvim/colors/vim-keitoku.vim 
    fi 
    echo "vim colorscheme updated"
}

tm() {
	if [ -f ./tmux.conf.local ]; then
		cp ./tmux.conf.local ~/.tmux.conf
	else
		cp ./tmux.conf ~/.tmux.conf
	fi

	if [ -n "$TMUX" ]; then
		tmux source-file ~/.tmux.conf 
	fi
    echo ".tmux.conf updated"
}

zshTheme() {
	cp ./keitoku.zsh-theme $OMZ/themes/keitoku.zsh-theme
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
    while getopts ":azvtZ" opt; do
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
