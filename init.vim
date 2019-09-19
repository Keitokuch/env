" neovim specific 
let g:python2_host_prog = system('which python')[:-2]
let g:python3_host_prog = system('which python3')[:-2]
 
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
set termguicolors 
set scrolloff=18
set showtabline=2

" -------------------- Color Scheme -------------------
let g:airline_theme='onehalfdark'
colorscheme vim-keitoku

" ============================ Key Mappings =============================
let mapleader=" "
inoremap jj <ESC>
map q <ESC>
nnoremap Q q
nnoremap <C-i> 10k
nnoremap <C-d> 10j

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
map <S-C-up> :resize +5<CR>
map <S-C-down> :resize -5<CR>
map <S-C-left> :vertical resize-5<CR>
map <S-C-right> :vertical resize+5<CR>

"" Tab
map <leader>t :tabe<CR>
map <leader>] :+tabnext<CR>
map <leader>[ :-tabnext<CR> 

"" Buffer 
map <leader>s :w<CR>
map <leader>q :qall<CR>
map <leader>w :q<CR>

"" Jumping
" tag jump
nnoremap <C-p> <C-]>
" next position
nnoremap <C-u> <C-i> 
" jump last tag 
nnoremap <C-y> <C-t>

"" Insert mode
inoremap <C-e> <ESC>$a
inoremap <C-a> <ESC>I
inoremap <C-f> <right>
inoremap <C-b> <left>

"" Terminal mode 
tnoremap jk <C-\><C-n>

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

autocmd Filetype tex inoremap <expr> $ strpart(getline('.'), col('.')-1, 1) == "$" ? "\<Right>" : "$$<left>"

"" ====================== Additional Features ========================
" Start from last position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Restore Session 
autocmd VimEnter * nested call StartSetup() 
autocmd VimLeave * call LeaveSetup()


"" ========================== Vim-Plug ========================
call plug#begin()

Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'lfv89/vim-interestingwords'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'sonph/onehalf', {'rtp':'vim/'}
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kingtaku/vterm'
Plug 'mg979/vim-visual-multi'
Plug 'dyng/ctrlsf.vim'
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'vim-scripts/TagHighlight'
Plug 'jistr/vim-nerdtree-tabs'

call plug#end()

" Automatically install missing plugins on startup
"if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
"  autocmd VimEnter * PlugInstall
"endif

" ====================== Plugin Configs ==========================

"" -------------------- Nerd-Tree ----------------------
map ss :NERDTreeToggle<CR>
map sf :NERDTreeFind<CR> 
let g:NERDTreeWinSize=24
let g:NERDTreeMinimalUI=1 
let NERDTreeMapOpenVSplit='so'
autocmd StdinReadPre * let s:std_in=1

" When NERDTree is the only window left 
" open empty buffer if started by opening a directory
" quit otherwise
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 0) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() && g:DIR_START == 1) | enew | exe 'NERDTreeToggle' | endif

" ---------------------- Nerdtree tabs --------------------
"map ss <plug>NERDTreeTabsToggle<CR>
"let g:nerdtree_tabs_open_on_console_startup = 1
"let g:nerdtree_tabs_autofind = 1

"" ------------------ vim-gitgutter -------------------
" unmap conflict leader combo 
let g:gitgutter_map_keys = 0 

"" ------------------- interesting words -------------------
map <silent> <leader>i <Plug>InterestingWords<nop>
map <silent> <leader>I <Plug>InterestingWordsClear
map n <Plug>InterestingWordsForeward
map N <Plug>InterestingWordsBackward

"" ------------------------------------ coc.nvim -------------------------------------------
" coc-python, coc-json, coc-pairs, coc-vimtex, coc-ultisnips 
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
nmap <silent> st :TagbarToggle<cr> 
let g:tagbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_map_jump = ["o", "<CR>"]
let g:tagbar_map_showproto = "v"
let g:tagbar_map_togglefold = "x"
let g:tagbar_map_zoomwin = "a"
let g:tagbar_map_togglesort = "ts"

" ------------------------------------ vim-gutentags ----------------------------------
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'

" ---------------------------------------- Leaderf ---------------------------------------------
let g:Lf_ShowRelativePath = -1
let g:Lf_HideHelp = 1
map <leader>p :LeaderfFunction!<cr>
map <leader>o :LeaderfFile<cr>
let g:Lf_NormalMap = {
	\ "File":   [["<leader>o", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
	\ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
	\ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
	\ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
	\ "Function":    [["<leader>p", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
	\ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
	\ }
let g:Lf_CommandMap = { '<C-j>' : ['<M-j>', '<Down>'], '<C-k>' : ['<M-k>', '<Up>'] }

" ------------------------------ ctrlsf ----------------------------
nmap     <C-f> <Plug>CtrlSFPrompt
vmap     <C-f> <Plug>CtrlSFVwordPath
nnoremap <leader>f :CtrlSFToggle<CR>

" ------------------------- vim-visual-multi -------------------------
let g:VM_theme = 'ocean'
nmap   <S-LeftMouse>         <Plug>(VM-Mouse-Cursor)
nmap   <S-RightMouse>        <Plug>(VM-Mouse-Word)  
nmap   <S-C-RightMouse>      <Plug>(VM-Mouse-Column)
let g:VM_maps = {}
let g:VM_maps["Switch Mode"]        = 'v'
let g:VM_maps['Find Under']         = '<C-n>'           
let g:VM_maps["Add Cursor Down"]    = '<S-Down>'      
let g:VM_maps["Add Cursor Up"]      = '<S-Up>'       
let g:VM_maps["Remove Region"]      = 'x'
let g:VM_maps["x"]                  = ''
let g:VM_maps["Skip Region"]        = '<C-x>'
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'
let g:VM_maps["Add Cursor At Pos"]  = '+'

" ------------------------- vimtex -------------------------
let g:tex_flavor='latex'
let g:vimtex_view_method='skim'
set conceallevel=1
let g:tex_conceal='abdmgs'
let g:vimtex_quickfix_mode=2
let g:vimtex_quickfix_autoclose_after_keystrokes = 3
let g:vimtex_quickfix_open_on_warning = 0 
let g:vimtex_quickfix_ignore_all_warnings = 1
let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : '.latex_aux',
    \}
augroup vimtex_config
    autocmd Filetype tex nmap <leader>c :VimtexCompile<CR> 
    " Start Compilation automatically on enter?
    "autocmd User VimtexEventInitPost VimtexCompile 
augroup end

"------------------------- ultisnips -------------------------  
let g:UltiSnipsExpandTrigger = 'C-;'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'

" ----------------------- cpp-enhanced-highlight ------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1


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

fu! StartSetup()
    if (argc() == 0 && !exists("s:std_in"))
        let g:DIR_START = 1 
        if !RestoreSess()
            exe 'NERDTreeToggle'
        endif 
    elseif argc() == 1 && isdirectory(argv()[0]) == 1 && !exists("s:std_in")
        let g:DIR_START = 1 
        exe 'cd ' . argv()[0]
        if !RestoreSess()
            exe 'NERDTreeToggle' argv()[0] | wincmd p | ene 
        endif 
    else
        let g:DIR_START=0 
    endif 
endfu 

fu! RestoreSess()
    if filereadable(getcwd() . '/.Session.vim')
        exe 'so ' . getcwd() . '/.Session.vim'
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exe 'sbuffer ' . l
                endif
            endfor
        endif
        exe 'NERDTreeFind' | wincmd p 
        return 1
    else 
        return 0 
    endif
endfunction

fu! LeaveSetup()
    let currTab = tabpagenr()
    tabdo NERDTreeClose | VTermClose 
    exe 'tabn ' . currTab 
    mksession! ./.Session.vim 
endfu 

