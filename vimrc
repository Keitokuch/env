set nocompatible
set number
set history=1000 
set background=dark 
syntax on 
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set showmatch
set guioptions-=T
set vb t_vb=
set ruler
set nohls
set incsearch
set runtimepath+=~/.vim
colorscheme ron
if has("vms")
set nobackup
else
set backup
endif
inoremap jj <ESC>
inoremap kj <ESC>
inoremap ;l <ESC>
filetype plugin on
					  
