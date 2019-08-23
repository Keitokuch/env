

set background=dark
highlight clear

if exists("syntax_on")
    syntax reset 
endif 

let g:colors_name="vim-keitoku"
let colors_name="vim-keitoku" 
let s:black       = { "gui": "#1c2833", "cterm": "234" }
let s:red         = { "gui": "#e06c75", "cterm": "168" }
let s:green       = { "gui": "#bae67e", "cterm": "149" }
let s:yellow      = { "gui": "#ffd580", "cterm": "215" }
let s:blue        = { "gui": "#6699cc", "cterm": "75"  }
let s:purple      = { "gui": "#cf51a1", "cterm": "176" }
let s:cyan        = { "gui": "#37dcee", "cterm": "81"  }
let s:white       = { "gui": "#e0e3e3", "cterm": "188" }
let s:orange      = { "gui": "#f99157", "cterm": "208" }
let s:opt         = { "gui": "#ffffff", "cterm": "74"} 
let s:class       = s:red 

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { "gui": "#5c6370", "cterm": "241" }
let s:gutter_bg   = { "gui": "#282c34", "cterm": "236" }
let s:gutter_fg   = { "gui": "#919baa", "cterm": "247" }

let s:cursor_line = { "gui": "#313640", "cterm": "237" }
let s:color_col   = { "gui": "#313640", "cterm": "237" }

let s:selection   = { "gui": "#474e5d", "cterm": "239" }
let s:vertsplit   = { "gui": "#313640", "cterm": "237" }

function! s:hi(group, fg, bg, attr)
    let hi_str = "hi " . a:group
    if !empty(a:fg)
        let hi_str .= " guifg=" . a:fg.gui . " ctermfg=" . a:fg.cterm 
    else
        let hi_str .= " guifg=NONE cterm=NONE"
    endif 
    if !empty(a:bg)
        let hi_str .= " guibg=" . a:bg.gui . " ctermbg=" .a:bg.cterm 
    else 
        let hi_str .= " guibg=NONE ctermbg=NONE"
    endif 
    if a:attr != ""
        let hi_str .= " gui=" . a:attr . " cterm=" . a:attr
    else 
        let hi_str .= " gui=NONE cterm=NONE"
    endif 
    exec hi_str 
endfunction  



" User interface colors {
call s:hi("Normal", s:fg, s:bg, "")
call s:hi("NonText", s:fg, {}, "")

call s:hi("Cursor", s:bg, s:blue, "")
call s:hi("CursorColumn", {}, s:cursor_line, "")
call s:hi("CursorLine", {}, s:cursor_line, "")

call s:hi("LineNr", s:gutter_fg, s:gutter_bg, "")
call s:hi("CursorLineNr", s:fg, {}, "")

call s:hi("DiffAdd", s:green, {}, "")
call s:hi("DiffChange", s:yellow, {}, "")
call s:hi("DiffDelete", s:red, {}, "")
call s:hi("DiffText", s:blue, {}, "")

call s:hi("IncSearch", s:bg, s:yellow, "")
call s:hi("Search", s:bg, s:yellow, "")

call s:hi("ErrorMsg", s:fg, {}, "")
call s:hi("ModeMsg", s:fg, {}, "")
call s:hi("MoreMsg", s:fg, {}, "")
call s:hi("WarningMsg", s:red, {}, "")
call s:hi("Question", s:purple, {}, "")

call s:hi("Pmenu", s:bg, s:fg, "")
call s:hi("PmenuSel", s:fg, s:blue, "")
call s:hi("PmenuSbar", {}, s:selection, "")
call s:hi("PmenuThumb", {}, s:fg, "")

call s:hi("SpellBad", s:red, {}, "")
call s:hi("SpellCap", s:yellow, {}, "")
call s:hi("SpellLocal", s:yellow, {}, "")
call s:hi("SpellRare", s:yellow, {}, "")

call s:hi("StatusLine", s:blue, s:cursor_line, "")
call s:hi("StatusLineNC", s:comment_fg, s:cursor_line, "")
call s:hi("TabLine", s:comment_fg, s:cursor_line, "")
call s:hi("TabLineFill", s:comment_fg, s:cursor_line, "")
call s:hi("TabLineSel", s:fg, s:bg, "")


call s:hi("Visual", {}, s:selection, "")
call s:hi("VisualNOS", {}, s:selection, "")

call s:hi("ColorColumn", {}, s:color_col, "")
call s:hi("Conceal", s:fg, {}, "")
call s:hi("Directory", s:blue, {}, "")
call s:hi("VertSplit", s:vertsplit, s:vertsplit, "")
call s:hi("Folded", s:fg, {}, "")
call s:hi("FoldColumn", s:fg, {}, "")
call s:hi("SignColumn", s:fg, {}, "")

call s:hi("MatchParen", s:blue, {}, "underline")
call s:hi("SpecialKey", s:fg, {}, "")
call s:hi("Title", s:green, {}, "")
call s:hi("WildMenu", s:fg, {}, "")

" Syntax colors {
call s:hi("Comment", s:comment_fg, {}, "italic")

call s:hi("Constant", s:green, {}, "")
call s:hi("String", s:green, {}, "")
call s:hi("Character", s:green, {}, "")
call s:hi("Number", s:cyan, {}, "")
call s:hi("Boolean", s:orange, {}, "")
call s:hi("Float", s:cyan, {}, "")

call s:hi("Identifier", s:yellow, {}, "")
call s:hi("Function", s:blue, {}, "")

call s:hi("Statement", s:purple, {}, "")
call s:hi("Conditional", s:orange, {}, "")
call s:hi("Repeat", s:orange, {}, "")
call s:hi("Label", s:purple, {}, "")
call s:hi("Operator", s:opt, {}, "")
call s:hi("Keyword", s:orange, {}, "")
call s:hi("Exception", s:red, {}, "")

call s:hi("PreProc", s:red, {}, "")
call s:hi("Include", s:red, {}, "")
call s:hi("Define", s:red, {}, "")
call s:hi("Macro", s:red, {}, "")
call s:hi("PreCondit", s:yellow, {}, "")

call s:hi("Type", s:class, {}, "")
call s:hi("StorageClass", s:class, {}, "")
call s:hi("Structure", s:class, {}, "")
call s:hi("Typedef", s:yellow, {}, "")

call s:hi("Conventional", s:cyan, {}, "italic") 

call s:hi("Special", s:red, {}, "")
call s:hi("SpecialChar", s:fg, {}, "")
call s:hi("Tag", s:fg, {}, "")
call s:hi("Delimiter", s:fg, {}, "")
call s:hi("SpecialComment", s:fg, {}, "")
call s:hi("Debug", s:fg, {}, "")

call s:hi("Underlined", s:fg, {}, "")
call s:hi("Ignore", s:fg, {}, "")
call s:hi("Error", s:red, s:gutter_bg, "")
call s:hi("Todo", s:purple, {}, "")


" }

