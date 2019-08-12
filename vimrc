" ----------------- Options ----------------
syntax on 
set nocompatible
set number
set relativenumber
set wrap
set showcmd
set wildmenu
filetype on

filetype indent on 
filetype plugin on 
filetype plugin indent on 
set encoding=utf-8
let &t_ut=''
set expandtab 
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
set hlsearch 
set incsearch
set smartcase
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set guioptions-=T
set vb t_vb=
set ruler
set nohls
set runtimepath+=~/.vim
if has("vms")
	set nobackup
else
	set backup
endif
set history=1000 
set laststatus=2    "always show status
""set autochdir
""set showmatch
""set background=dark 
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ------------------- Appearance -------------------
colorscheme ron

""color snazzy

" ------------------- Key Mappings ------------------
let mapleader=" "
map s <nop>
map t <nop>
inoremap jj <ESC>
nnoremap <C-k> <C-w>
nnoremap <C-i> 10kzz
nnoremap <C-d> 10jzz

"" Split
map sr :set splitright<CR>:vsplit<CR>
map sd :set splitbelow<CR>:split<CR>
map <leader>l <C-w>l
noremap <leader>h <C-w>h
map <leader>p <C-w>k
map <leader>n <C-w>j
map <up> :resize +5<CR>
map <down> :resize -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"" Tab
map tt :tabe<CR>
map tl :+tabnext<CR>
map th :-tabnext<CR>

map te :q<CR>
map <leader>s :w<CR>
map <leader>q :q<CR>
map <leader>sq :wq<CR>

"" Auto brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"<left>""
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'

" Cursor Configuration !!
" 5 for blinking I-beam
" 3 for blinking underline
" 2 for blinking block

""hi CursorLine cterm=NONE ctermbg=22
""hi CursorColumn cterm=NONE ctermbg=22
""autocmd InsertEnter * set cul
""autocmd InsertLeave * set nocul 
""autocmd InsertEnter * set cursorcolumn
""autocmd InsertLeave * set nocursorcolumn

""autocmd VimLeave * silent !echo -ne "\e[3 q"
""autocmd VimEnter * silent !echo -ne "\e[2 q"

if exists('$TMUX')
	let &t_SI = "\ePtmux;\e\e[3 q\e\\"
	let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
	let &t_SI = "\e[3 q"
	let &t_EI = "\e[2 q"
endif



""let &t_SR = "\<Esc>[4 q"
""let &t_SR = "\<Esc>[2 q"

""let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
""let &t_SI = "\<esc>[3 q"  " steady underline in insert mode
""let &t_SR = "\<esc>[0 q"  " blinking block in replace mode
""let &t_EI = "\<esc>[2 q"  " default cursor (usually blinking block) otherwise]"]"]"


"" ----------------- Vim-Plug ---------------
call plug#begin('~/.vim/plugged') 

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'lfv89/vim-interestingwords'
Plug 'connorholyday/vim-snazzy'
""Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 

call plug#end() 


" --------------- Plugin Configs ----------------
map ss :NERDTreeToggle<CR>

"" -------------- vim-gitgutter -----------------
let g:gitgutter_map_keys = 0 



