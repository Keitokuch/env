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

filetype plugin on

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
