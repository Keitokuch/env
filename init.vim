" neovim specific 
let g:python2_host_prog = system('which python')
let g:python3_host_prog = system('which python3')
 
" ----------------- Options ----------------
syntax on 
set nocompatible
set number
set relativenumber
set wrap
set showcmd
set wildmenu
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
set history=1000 
set laststatus=2    "always show status
set clipboard=unnamed 
set mouse=a

" -------------------- Color Scheme -------------------
let g:airline_theme='onehalfdark'
colorscheme vim-keitoku

" ============================ Key Mappings =============================
let mapleader=" "
inoremap jj <ESC>
nnoremap <C-i> 10k10<C-y>
nnoremap <C-d> 10j10<C-e>

"" Split
map s <nop>
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>
map <leader>l <C-w>l
map <leader>h <C-w>h
map <leader>k <C-w>k
map <leader>j <C-w>j
map <up> :resize +5<CR>
map <down> :resize -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"" Tab
map st :tabe<CR>
map <leader>] :+tabnext<CR>
map <leader>[ :-tabnext<CR> 

"" Buffer 
map <leader>s :w<CR>
map <leader>q :q<CR>

"" Jumping
" tag jump
nnoremap <C-p> <C-]>
" next position
nnoremap <C-u> <C-i> 
" jump last tag 
nnoremap <C-n> <C-t>

"" Insert mode
inoremap <C-e> <ESC>$a
inoremap <C-a> <ESC>I
inoremap <C-f> <right>
inoremap <C-b> <left>

" Minimal auto closing
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

"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"" ========================== Vim-Plug ========================
call plug#begin()

Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'lfv89/vim-interestingwords'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'sonph/onehalf', {'rtp':'vim/'}
Plug 'dense-analysis/ale'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'majutsushi/tagbar'
Plug 'cohama/lexima.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kingtaku/vterm'

call plug#end()


" ====================== Plugin Configs ==========================

"" -------------------- Nerd-Tree ----------------------
map ss :NERDTreeToggle<CR>
let g:NERDTreeWinSize=24
let g:NERDTreeMininalUI=1 
let NERDTreeMapOpenVSplit='so'
autocmd StdinReadPre * let s:std_in=1
" Open NERDTree if a directory if opened
let g:DIR_ENTER=0 
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) == 1 && !exists("s:std_in") | let g:DIR_ENTER=1 | exe 'NERDTreeToggle' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Open NERDTree if no argument 
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | let g:DIR_ENTER=1 | exe 'NERDTreeToggle' | endif
" Default cursor to opened file window 
autocmd VimEnter * if argc() | wincmd p | endif 
" Quit if NERDTree is the only window left 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_ENTER != 1) | q | endif

"" ------------------ vim-gitgutter -------------------
" unmap conflict leader combo 
let g:gitgutter_map_keys = 0 

"" ------------------- interesting words -------------------
map <silent> <leader>i <Plug>InterestingWords<nop>
map <silent> <leader>I <Plug>InterestingWordsClear
map n <Plug>InterestingWordsForeward
map N <Plug>InterestingWordsBackward

"" ---------------------- coc.nvim ---------------------------
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use <tab> and <s-tab> for trigger completion and navigate to complete items
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" make <cr> select the first completion item and confirm the completion when no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ------------------------- Tagbar ----------------------------
nmap <silent> <leader>t :TagbarToggle<cr> 
let g:tagbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_map_jump = ["o", "<CR>"]
let g:tagbar_map_showproto = "v"
let g:tagbar_map_togglefold = "x"
let g:tagbar_map_zoomwin = "a"

" ------------------------- Leaderf ---------------------------
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1 
map <leader>p :LeaderfFunction!<cr>
map <leader>o :LeaderfFile<cr>

" ------------------------- lexima ---------------------------
let g:lexima_enable_endwise_rules = 1
let g:lexima_enable_newline_rules = 1


" ======================== Languages ==========================

" ------------- Python ---------------
let g:pymode_python = 'python3'
let g:pymode_syntax_space_errors = 0
hi def link pythonParam             Identifier 
hi def link pythonClassParameters   Identifier
hi def link pythonSelf              Conventional
hi def link pythonOperator          Keyword
hi def link pythonFunction          FunctionDeclaration 
hi def link pythonBuiltinFunc       BuiltinFunc 
au Filetype python syntax match pythonFunctionCall /\v[[:alpha:]_]+\ze(\s?\()/
hi def link pythonFunctionCall FunctionCall

" ================== Utils ===================
function! <SID>SynStack()

    if !exists("*synstack")

        return

    endif

    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')

endfunc

nnoremap <C-g> :call <SID>SynStack()<CR>


