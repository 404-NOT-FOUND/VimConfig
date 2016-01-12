
" 设定默认配色
colo Tomorrow-Night

" 设定特殊文件类型的配色
au BufEnter *.mp,*.vim colo Tomorrow-Night
au BufEnter *.cpp,*.java colo Tomorrow-Night
au BufEnter *.py call UseSolarizedDarkColor()
au BufEnter *.notes,*.tex,*.{md,mdown,mkd,mkdn,markdown,mdwn,mk}
            \ call UseSolarizedDarkColor()

func! UseSolarizedDarkColor()
    let g:solarized_italic=0          " 不使用斜体
    set background=dark               " 用暗版 solarized
    colo solarized
endfunc

" 当 Vim 在后台时改变配色。重新回到 Vim 时还原
au FocusLost * let b:current_color=g:colors_name | colo slate
au FocusGained * if exists('b:current_color') | exe 'colo '.b:current_color | endif

" 不高亮当前行
set nocursorline
au BufReadPost * hi CursorLine term=underline cterm=underline guibg=#404040

" guibg		- 背景色
" guifg		- 前景色

" 改变自动补全窗口配色
" Pmenu		- 所有项的配色
" PmenuSel	- 选中项的配色
" au BufReadPost * hi Pmenu	guibg=#101010	guifg=#909090 gui=none
au BufReadPost * hi Pmenu guibg=darkgrey  guifg=black
au BufReadPost * hi PmenuSel guibg=lightgrey guifg=black

" au BufReadPost * hi preproc	 guifg=#005cff	ctermfg=blue
"au BufReadPost *.h,*.c,*.cpp,*.java,*.tex,*.mp 
"			\hi comment	 guifg=lightgreen	 ctermfg=lightgreen	ctermbg=black	gui=none
" 标识符,如lua中的function end if 
" au BufReadPost * hi identifier	guifg=#005cff	 ctermfg=red	gui=none

" 标签
au BufReadPost * hi TabLine guifg=black gui=none
au BufReadPost * hi TabLineSel	gui=none
au BufReadPost * hi TabLineFill	guibg=darkgrey	gui=none
au BufReadPost * hi MatchParen ctermbg=blue guibg=lightblue guifg=black

" Groups for syntax highlighting
" au BufReadPost * hi Special term=bold ctermfg=LightRed guifg=Orange guibg=grey5
" au BufReadPost * hi Ignore ctermfg=DarkGrey guifg=grey20

