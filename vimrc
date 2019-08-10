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
nnoremap <C-k> <C-w>

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

""filetype plugin on

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

" Cursor Configuration !!
" 5 for blinking I-beam
" 3 for blinking underline
" 2 for blinking block

hi CursorLine cterm=NONE ctermbg=22
hi CursorColumn cterm=NONE ctermbg=22
""autocmd InsertEnter * set cul
""autocmd InsertLeave * set nocul 
""autocmd InsertEnter * set cursorcolumn
""autocmd InsertLeave * set nocursorcolumn

autocmd VimLeave * silent !echo -ne "\e[3 q"
autocmd VimEnter * silent !echo -ne "\e[2 q"

if exists('$TMUX')
	let &t_SI = "\ePtmux;\e\e[3 q\e\\"
	let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
	let &t_SI = "\e[3 q"
	let &t_EI = "\e[2 q"
endif


""let &t_SI = "\<Esc>[6 q"
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

call plug#end() 
"" --------------- END Vim-Plug -------------
