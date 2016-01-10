
" =============================================================================
" 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim
" =============================================================================

" 判断操作系统是否是 Windows 还是 Linux
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" 判断是终端还是 Gvim
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
" 软件默认配置
" =============================================================================

if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    " source $VIMRUNTIME/mswin.vim
    " behave mswin
    " set diffexpr=MyDiff()
    set diffexpr=

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" 复原 'cpoptions'
" 不明所以，来自 $VIMRUNTIME/mswin.vim
" set cpo&
" if 1
"   let &cpoptions = s:save_cpo
"   unlet s:save_cpo
" endif

" =============================================================================
" 配色
" =============================================================================
if g:iswindows
    source $vim/vimfiles/colors/myColor.vimrc
else
    source ~/.vim/colors/myColor.vimrc
endif

" =============================================================================
" Vundle 插件管理工具
" =============================================================================
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" 如果想在 windows 安装就必需先安装 "git for window"，可查阅网上资料

" 必需配置
set nocompatible                                    " 禁用 Vi 兼容模式
filetype off                                        " 禁用文件类型侦测
                                                    " 注意之后打开

if g:islinux
    set runtimepath+=~/.vim/bundle/vundle.vim
    call vundle#begin()
else
    set runtimepath+=$vim/vimfiles/bundle/Vundle.vim
    call vundle#begin('$vim/vimfiles/bundle/')
endif

" 使用 Vundle 来管理 Vundle，必须要有
Plugin 'VundleVim/Vundle.vim'

" 以下为要安装或更新的插件
Plugin 'a.vim'
Plugin 'grep.vim'
Plugin 'Align'
Plugin 'jiangmiao/auto-pairs'
" Plugin 'bufexplorer.zip'
" Plugin 'ccvext.vim'
" Plugin 'Yggdroot/indentLine'
" Plugin 'Mark--Karkat'
Plugin 'Shougo/neocomplete'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/VimIM'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'OmniCppComplete'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'msanders/snipmate.vim'
" Plugin 'wesleyche/SrcExpl'
" Plugin 'std_c.zip'
" Plugin 'tpope/vim-surround'
" Plugin 'scrooloose/syntastic'
" Plugin 'majutsushi/tagbar'
" Plugin 'ZoomWin'
Plugin 'tpope/vim-markdown'
" Plugin 'shawncplus/phpcomplete.vim'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'cSyntaxAfter'
" Plugin 'javacomplete'
" Plugin 'vim-javacompleteex'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'davidhalter/jedi-vim'               " 'pip install jedi' installed
" Plugin 'mattn/emmet-vim'
" Plugin 'fholgado/minibufexpl.vim'         "好像与 Vundle 插件有一些冲突
" Plugin 'Shougo/neocomplcache.vim'
" Plugin 'repeat.vim'
" Plugin 'ervandew/supertab'                "有时与 snipmate 插件冲突
Plugin 'taglist.vim'
" Plugin 'TxtBrowser'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'exvim/ex-minibufexpl'                "exvim插件之一。修复BUG

call vundle#end()

" =============================================================================
" 编码配置
" =============================================================================

" 注：使用 utf-8 格式后，软件与程序源码、文件路径不能有中文，否则报错
" 设定新文件使用的解码
set encoding=utf-8
" 设置支持打开的文件的编码
set fileencodings=utf-8,cp936,utf-16le,usc-bom,gbk,euc-jp,chinese,gb18030,ucs,gb2312,big5

" 设置新文件的 <EOL> 格式
set fileformat=unix
" 设置支持的 <EOL> 格式
set fileformats=unix

" 将程序语言设为英文
" 设置信息语言
let $LANG = 'en'
" 设置菜单语言
set langmenu=en

" 设置拼写检查语言为美式英语
set spelllang=en_us
" 使拼写检查忽略东亚字符
set spelllang+=cjk

" =============================================================================
" 界面配置
" =============================================================================

" 设置欢迎界面
set shortmess=atI

" 关闭提示音
set noerrorbells
set vb t_vb=

if g:isGUI
    " 设置菜单界面
	set guioptions-=a                   " for windows
	set guioptions=                     " 完全取消菜单界面

    " 设置 gVim 窗口初始位置及大小
    " au GUIEnter * simalt ~x           " 窗口启动时自动最大化
    winpos 0 0                          " 指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=100            " 指定窗口大小，lines为高度，columns为宽度

    " 设定默认字体
    let g:guifont='Consolas'
    let g:guifontwide='FZLanTingHeiS-EL-GB'
    let g:guifontwide='YaHei_Consolas_Hybrid'
    let g:guifontsize=12
    " 提供改变字号的函数
    fun SetGuiFontSize(s)
        exec 'set guifont=' . g:guifont . ':h' . string(a:s)
        exec 'set guifontwide=' . g:guifontwide . ':h' . string(a:s)
        let g:guifontsize=a:s
    endfunc
    " 默认 10.5 号字
    call SetGuiFontSize(10.5)
endif

" 光标移动到 buffer 的顶部和底部时保持 3 行距离
set scrolloff=3

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

" 状态行
set statusline=
"set statusline+=%2*%-3.3n%0*    " buffer number
set statusline+=%f               " file name
set statusline+=%m%r%h%w         " flag. [+] for changed/unsaved
set statusline+=[%{&encoding}]   " encoding
set statusline+=[POS=%l,%v]      " position
set statusline+=[%p%%]           " percentage of file
set statusline+=%=               " right align
set statusline+=%{strftime(\"%m/%d/%y\ -\ %H:%M\")}\  " time
" 总是显示状态行
set laststatus=2

" 命令行的高度
set cmdheight=2

" 总是显示标签栏
" set showtabline=2

" 当缓冲区被丢弃的时候隐藏它
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" =============================================================================
" 核心设置
" =============================================================================

" 自动改变 vim 的当前目录为打开的文件所在目录
set autochdir

" 不要备份文件
set nobackup
" set nowb
" set noundofile

" 不要生成 swap 文件
set noswapfile

" 文本修改记录
set undofile
if g:iswindows
    set undodir=C:\\Windows\\Temp
endif

" cmd line 中的命令数记录
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 与 windows 共享剪贴板
set clipboard+=unnamed

" 保存全局变量
set viminfo+=!

" 增强模式中的命令行自动完成操作
set wildmenu

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 通过使用 :commands 命令，告诉我们文件的哪一行被改变过
set report=0

" =============================================================================
" 操作
" =============================================================================

" 不要使用 vi 的键盘模式，而是 vim 的
set nocompatible

" 设置 leader 健
let g:mapleader = ","

" 保存
nnoremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>

" 使用 ctrl-y 重做 (redo)
noremap <C-Y> <C-R>

" 在命令行下使用 ctrl-v 粘贴
cmap <C-V> <C-R>+

" 删除所有行尾多余的空白（空格或 tab ）
nmap <F12>   :let g:winview = winsaveview()<CR>
            \:%s+\s\+$++e<CR>
            \:nohls<CR>
            \:call winrestview(g:winview)<CR>
            \:echo 'Trialing spaces cleared'<CR>

" 取消搜索结果高亮
nmap <F11> :nohls<CR>

" ctrl-c 计算器
if has('python')
    imap <silent> <C-C> <C-R>=pyeval(input('Calculate: '))<CR>
else
    imap <silent> <C-C> <C-R>=string(eval(input("Calculate: ")))<CR>
endif

" 时间戳
imap ,time <c-r>=strftime("20%y-%m-%d")<cr>

" 将大写 Y 改成从光标位置复制到行尾以与大写 D 对应
nnoremap Y y$

" 使用方向键以在被折叠的行间移动
nnoremap <up> gk
vnoremap <up> gk
inoremap <up> <c-o>gk
nnoremap <down> gj
vnoremap <down> gj
inoremap <down> <c-o>gj

" 使回退键（backspace）正常跨行
set backspace=indent,eol,start

" 允许左右移动跨越行边界
" set whichwrap+=<,>,h,l

" 允许 ctrl-q 进入块选模式 (visual block mode)
noremap <C-Q> <C-V>

" 用空格键来开关折叠
set foldmethod=manual
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>:echo<CR>

" 窗口控制
" 使用 <leader>. 和 <leader>m 前后切换 Buffer
nmap <silent> <leader>. :bnext<CR>:buffers<CR>
nmap <silent> <leader>m :bprevious<CR>:buffers<CR>
" 使用 ctrl+j,k,h,l 切换分割的视窗
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" 标签控制
" 使用 ctrl+n 和 ctrl+x 打开/关闭标签
" nnoremap <c-n> :tabnew<CR>:e
" nnoremap <c-x> :tabc<CR>
" 使用 ctrl+Tab 切换标签
nnoremap <c-TAB> :tabnext<CR>
nnoremap <c-s-TAB> :tabprevious<CR>

" =============================================================================
" 搜索和匹配
" =============================================================================

" 高亮显示匹配的括号
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 在搜索的时候忽略大小写
set ignorecase

" 如果搜索模式包含大写字符，不使用 'ignorecase' 选项
set smartcase

" 在搜索时，输入的词句的逐字符高亮
set incsearch

" 对空白字符的显示配置
" 使用 :set list 来显示空白字符
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 不要闪烁
set novisualbell

" F3 在工作路径中搜索（grep）
nmap <F3> :call MyQuickGrep()<CR>

" =============================================================================
" 文本格式和排版
" =============================================================================

" 侦测文件类型
filetype on

" 载入文件类型插件
filetype plugin on

" 为特定文件类型载入相关缩进文件
filetype indent on

" 语法高亮
syntax on

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为 C-like 程序提供自动缩进
set smartindent

" 使用 C 样式的缩进
" set cindent

" 在 (La)TeX 用 lists 的时候。item 缩进有问题。直接关掉
let g:tex_indent_items=0 

" 制表符显式为 4 个空格长
set tabstop=4

" 统一缩进为 4 个空格长
set shiftwidth=4
set smarttab        " 使 softtabstop = shiftwidth

" 使用空格填充制表符
set expandtab

" 不要折行
"set nowrap

" vim 自带补全功能的列表索引次序
" 默认值 . , w , b , u , U , t , i
" 补全列表会先搜索当前文件(.)
" 再搜索其他窗口(w)
" 再搜索其他缓冲区(b)
" 再搜索已经卸载的缓冲区(u)
" 再搜索不在缓冲区列表中的缓冲区，即工作路径中的缓冲区(U)
" 再搜索 tags (t)
" 最后搜索源码中通过 #include 包含进来的头文件(i)
set complete=.,w,b,u

" 文本格式化设置
" t     根据 textwidth 自动折行
" c     为 comments 格式化 (see :h comments)
" r     手动回车时插入合适的注释符
" q     允许 gq 命令
" n     识别编号列表 1) 2) . . . (与 2 冲突，需要 autoindent)
" 2     使用一段的第二行缩进来格式化文本
" l     不根据 textwidth 自动折行
" m     在多节字符处可以折行
" M     在拼接两行时，遇到多节字符则不插入空格
set formatoptions+=mM   " 方便中文文本操作
" 自动文本格式化的行宽
set textwidth=80

" 如下符号可以连接两个词
set iskeyword+=_,#

" =============================================================================
" Autocommands
" =============================================================================

if has("autocmd")

" 打开文件时定位至关闭时位置
au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe " normal g`\"" |
            \ endif

" 将特殊后缀的文件设置为相应格式
au BufReadPost *.mk setlocal filetype=markdown
au BufReadPost *.notes setlocal filetype=notes

" 为 txt 文件还原 TAB 长度
au BufReadPost *.txt setlocal tabstop=8
au BufReadPost *.txt setlocal shiftwidth=8
" au BufReadPost *.txt setlocal smarttab

" 自动创建折叠
" au BufReadPost *.h,*.c,*.cpp set foldexpr=FoldBrace(0)
" au BufReadPost *java set foldexpr=FoldBrace(1)
" au BufReadPost *.h,*.c,*.cpp,*java set foldmethod=expr
" au BufReadPost *.h,*.c,*.cpp,*java set foldmethod=syntax    " 使用 vim 默认的 fold syntax
" au BufReadPost *.h,*.c,*.cpp,*java set foldmethod=indent    " 根据缩进折叠
set foldenable

" 拼写检查 spell check
au BufReadPost *.tex,*.notes setlocal spell
au BufReadPost *.notes setlocal spellcapcheck=              " 禁止大小写检查

" 自动补全括号
" au Filetype c,cpp,java,tex,mp call CompleteBrackets()

" F5 编译和运行程序
au Filetype java call SetMakeRunJavac()
au Filetype cpp call SetMakeRunGpp()
au FileType tex call SetMakeRunXeLaTeX()
au Filetype mp call SetMakeRunMpost()

" 打开 tex 文件时自动打开相应的 pdf
au VimEnter *tex call OpenTeXworks()
au BufAdd   *tex call OpenTeXworks()

" " C-] 与 C-[ 注释
" au Filetype java,cpp,h,c call SetComments('c')
" au Filetype tex,mp call SetComments('tex')
" au Filetype vim,vimrc call SetComments('vim')

" 使用 z] 将选中文本包围在一对 $ 中 (LaTeX math mode)
au BufReadPost *.tex,*.notes vnoremap z] <Esc>`<i$<Esc>`>a$<Esc>
au BufReadPost *.notes,*.tex nmap z] viwz]

" 使用 <space>] 强调文本
au BufReadPost *.notes vnoremap <space>] <Esc>`<i\|<Esc>`>a\|<Esc>
au BufReadPost *.markdown vnoremap <space>] <Esc>`<i*<Esc>`>a*<Esc>
au BufReadPost *.notes,*.{md,mdown,mkd,mkdn,markdown,mdwn,mk}
            \ nmap <space>] viw<space>]

" 显示行号
au FileType xml,html,c,S,cs,java,perl,shell,bash,cpp,python,vim,php,ruby,tex,mp
			\ setlocal number

" 制作标签
if g:iswindows
    au FileType cpp,h setlocal tags+=$vim/vimfiles/myVim/cppTags
    au FileType java setlocal tags+=$vim/vimfiles/myVim/javaTags
else
    au FileType cpp,h setlocal tags+=~/.vim/myVim/cppTags
    au FileType java setlocal tags+=~/.vim/myVim/javaTags
endif
au BufReadPost *.cpp nmap <F10>
            \ :silent !ctags -R --sort=yes --c++-kinds=+p
			\ --fields=+iaS --extra=+q --language-force=C++ .<CR>
au BufReadPost *.java nmap <F10>
            \ :silent !ctags -R --fields=+afikmsSt --extra=+q
            \ --java-kinds=+cfimlp --languages=Java .<CR>

" 文本格式化行宽
au FileType html,text,php,vim,c,cpp,java,xml,bash,shell,perl,python,tex
            \ setlocal textwidth=79
au FileType markdown setlocal tw=0

" 高亮超过规定行宽（79）的字符
" au BufWinEnter *html,*php,*c,*cpp,*java
"             \ let w:m2=matchadd('Underlined', '\%>' . 79 . 'v.\+', -1)

" closetag 插件
" if:iswindows
"     au Filetype html,xml,xsl source $vim/vimfiles/scripts/closetag.vim
" else
"     au Filetype html,xml,xsl source ~/.vim/scripts/closetag.vim
" endif

" markdown preview (需要 CHROME 并装有 markdown preview plus 插件)
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}
            \ map <Leader>p :silent ! start chrome --new-window "%:p"<CR>

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

endif "has("autocmd")

" =============================================================================
" 自定义函数
" =============================================================================

" 清理 TeX 的记录、标签文件
func! TeXclean()
	exec 'silent !rm
                \ %<.mpx %<.log %<.aux %<.out %<.synctex.gz
                \ %<.synctex.gz^(busy^) %<.toc %<.bbl %<.blg mpxerr.tex
                \ %<.nav %<.snm mptextmp.mpx mptextmp.mp
                \ %<.[0-9] %<.[0-9][0-9] %<.[0-9][0-9][0-9]'
endfunc

" ------------------------------------------------------------

" MetaPost 的编译与运行
func! SetMakeRunMpost()
	nmap <buffer> <F5> :call CompileMpost()<CR>
	nmap <buffer> <c-s-F5> :call CompileRunMpost()<CR>
	nmap <buffer> <c-CR> :call RunMpost()<CR>
"                 \ :texworks 'silent !%<-' .
"                 \ input('Open figure number: ') . '.pdf'<CR>
endfunc
func! CompileRunMpost()
    call CompileMpost()
    call RunMpost()
endfunc
func! CompileMpost()
	exec "w"
	exec "!mpost -tex=latex %"
	exec "!mptopdf %<.?"
	call TeXclean()
endfunc
func! RunMpost()
	exec "silent !%<-" . input('Open figure number: ') . ".pdf"
endfunc

" ------------------------------------------------------------

" XeLaTeX 的编译与运行
func! SetMakeRunXeLaTeX()
"     if g:iswindows
"         exec 'silent !if exist %<.pdf (start texworks %<.pdf)'
"     else
"         exec 'silent !if [ -e %<.pdf ]; then start texworks %<.pdf; fi'
"     endif
	nmap <buffer> <F5> :call CompileXeLaTeX()<CR>
	nmap <buffer> <c-F5> :call CompileRunXeLaTeX()<CR>
	nmap <buffer> <c-CR> :call TeXclean()<CR>:silent !%<.pdf ^&<CR>
endfunc
func! OpenTeXworks()
    if g:iswindows
        exec 'silent !if exist <afile><.pdf (start <afile><.pdf)'
    else
        exec 'silent !if [ -e <afile><.pdf ]; then start <afile><.pdf; fi'
    endif
endfunc
func! CompileXeLaTeX()
	exec "!xelatex %"
endfunc
func! CompileRunXeLaTeX()
	exec "w"
	exec "silent !xelatex -quiet %"
	exec "silent !xelatex -quiet %"
	call TeXclean()
	exec "silent !%:r.pdf ^&"
endfunc

" ------------------------------------------------------------

" Java 的编译与运行
func! SetMakeRunJavac()
	:set makeprg=javac\ %
	nmap <buffer> <F5> :call MakeRunJava()<CR>
	nmap <buffer> <c-CR> :!java %<<CR>
endfunc
func! MakeRunJava()
	exec "w"
	exec "make"
	try
		exec "cc"
	catch
		exec "!java %<"
	endtry
endfunc

" ------------------------------------------------------------

" C++ 的编译与运行
func! SetMakeRunGpp()
	:set makeprg=g++\ %:h/*cpp\ -o\ %<.exe
	nmap <buffer> <F5> :call MakeRunGpp()<CR>
	nmap <buffer> <c-CR> :!%<.exe<CR>
endfunc
func! MakeRunGpp()
	exec "w"
	exec "make"
	try
		exec "cn"
	catch
		exec "!%<.exe"
	endtry
endfunc

" ------------------------------------------------------------

" 范围添加注释
" func! SetComments(char)
" 	if a:char == 'c'
" 		map c] :s+^\(\s*[^ \t]\)+// \1+ge<CR>
" 					\/<UP><UP><CR><c-o>
" 					\:nohls<CR>
" 					\:echo "comments added"<CR>
"
" 		map c[ :s+^\(\s*\)// +\1+ge<CR>
" 					\/<UP><UP><CR><c-o>
" 					\:nohls<CR>
" 					\:echo "comments removed"<CR>
"
" 	elseif a:char == 'tex'
" 		map c] :s+^+% +ge<CR>:nohls<CR>:echo "comments added"<CR>
" 		map c[ :s+^\(\s*\)%[ ]*+\1+ge<CR>:nohls<CR>:echo "comments removed"<CR>
" 	elseif a:char == 'vim'
" 		map c] :s+^+" +ge<CR>:nohls<CR>:echo "comments added"<CR>
" 		map c[ :s+^\(\s*\)"[ ]*+\1+ge<CR>:nohls<CR>:echo "comments removed"<CR>
" 	endif
" endfunc

" ------------------------------------------------------------

" 自动折叠函数和大段注释
" func! FoldBrace(int)
" 	" functions
" 	if getline(v:lnum) =~ ')'	" make sure it's a function
" 		" '{' could be on the second line
" 		if getline(v:lnum+1)[a:int] == '{'
" 			return 1
" 		endif
" 		" or the same line as the definition
" 		if getline(v:lnum) =~ '{' && !(getline(v:lnum) =~ '}')
" 			return 1
" 		endif
" 	endif
" 	" look for '}' and not '};' since a func def can't end with it
" 	if getline(v:lnum)[a:int] == '}' && !(getline(v:lnum) =~ '};')
" 		return '<1'
" 	endif

"	" block comments
"	if getline(v:lnum-1) =~ '/\*' && !(getline(v:lnum) =~ '\*/')
"								\ && !(getline(v:lnum+1) =~ '\*/')
"		return 2
"	endif
"	if getline(v:lnum+1) =~ '\*/'
"		return '<2'
"	endif
" 	" default
" 	return -1
" endfunc

" 自动补全括号
" func! CompleteBrackets()
" 	inoremap <buffer> ( ()<Left>
" 	inoremap <silent> <buffer> ) <c-r>=ClosePair(')')<CR>
" 	inoremap <buffer> { {}<Left>
" 	inoremap <silent> <buffer> } <c-r>=ClosePair('}')<CR>
" 	inoremap <buffer> [ []<Left>
" 	inoremap <silent> <buffer> ] <c-r>=ClosePair(']')<CR>
" 	"inoremap <buffer> " ""<Left>
" 	"inoremap <buffer> ' ''<Left>
" 	inoremap <buffer> <CR> <c-r>=MultilineBrackets()<CR>
" endfunc
" "实现括号的自动配对后防止重复输入
" function! ClosePair(char)
"     if getline('.')[col('.') - 1] == a:char
"         return "\<Right>"
"     else
"       return a:char
"    endif
" endf
" func! MultilineBrackets()
" 	echo getline('.')[col('.') - 2]
" 	echo getline('.')[col('.') - 1]
" 	if    ( getline('.')[col('.') - 2] == '(' && getline('.')[col('.')-1] == ')' )
" 	 \ || ( getline('.')[col('.') - 2] == '[' && getline('.')[col('.')-1] == ']' )
" 	 \ || ( getline('.')[col('.') - 2] == '{' && getline('.')[col('.')-1] == '}' )
" 		return "\r\<ESC>\<s-o>"
" 	else
" 		return "\r"
" endfunc

" ------------------------------------------------------------

" 使用 Vim[grep] 来 grep
function MyQuickGrep()
    let pattern = input('Search for pattern: ')
    let filename = input('Search in files: ')
    exe 'redraw'

    if (pattern == '')
		echohl WarningMsg | echo 'Please enter a search pattern' | echohl None
        exe "normal \<ESC>"
    elseif (filename == '')
        "echohl WarningMsg | echo 'Please enter filename(s)' | echohl None
        "exe "normal \<ESC>"
        let filename = '*'
    endif
    try
        exe 'vimgrep /' . pattern . '/j ' . filename . '|copen'
        " j option inhibits jumping to search results
        " open quickfix for result browsing
    endtry
endfunction

" ------------------------------------------------------------

" " 能够漂亮地显示.NFO文件
" function! SetFileEncodings(encodings)
" let b:myfileencodingsbak=&fileencodings
" let &fileencodings=a:encodings
" endfunction
" function! RestoreFileEncodings()
" let &fileencodings=b:myfileencodingsbak
" unlet b:myfileencodingsbak
" endfunction

" =============================================================================
" 插件配置
" =============================================================================

" -----------------------------------------------------------------------------
" a.vim
" -----------------------------------------------------------------------------
" 用于切换C/C++头文件
" :A     ---切换头文件并独占整个窗口
" :AV    ---切换头文件并垂直分割窗口
" :AS    ---切换头文件并水平分割窗口

" -----------------------------------------------------------------------------
" QuickFix
" -----------------------------------------------------------------------------

" QuickFix 中文支持
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉

if g:iswindows
	au QuickfixCmdPost make call QfMakeConv()
	func! QfMakeConv()
		let qflist = getqflist()
		for i in qflist
			let i.text = iconv(i.text, "cp936", "utf-8")
		endfor
		call setqflist(qflist)
		exec "cw"
	endfunc
endif

" -----------------------------------------------------------------------------
" TagList & Ctags
" -----------------------------------------------------------------------------
" 对于C++代码，ctags需要额外使用以下选项：
" --c++-kinds=+p
"		为标签添加函数原型(prototype)信息
" --fields=+iaS
"		为标签添加继承信息(inheritance)，访问控制(access)信息，
"		函数特征(function Signature,如参数表或原型等)
" --extra=+q
"		为类成员标签添加类标识
set tags=tags

" 配置 TagList 的 ctags 路径
let Tlist_Ctags_Cmd = "%VIMRUNTIME%\\ctags.exe"

" 按照名称排序
let Tlist_Sort_Type = "name"

" 压缩方式
" let Tlist_Compart_Format = 1

" 如果 taglist 窗口是最后一个窗口，则退出 vim
let Tlist_Exist_OnlyWindow = 1

" 不要关闭其他文件的tags
let Tlist_File_Fold_Auto_Close = 0

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 1

" 让当前不被编辑的文件的方法列表自动折叠起来
let Tlist_File_Fold_Auto_Close = 1

let Tlist_Show_One_File = 1

nmap <Leader>tl :TlistToggle<CR>

" -----------------------------------------------------------------------------
" OmniCppComplete
" -----------------------------------------------------------------------------

" 打开全局查找控制
let OmniCpp_GlobalScopeSearch = 1

" 类成员显示控制，不显示所有成员
let OmniCpp_DisplayMode = 0

" 控制匹配项所在域的显示位置。
" 缺省情况下，omni显示的补全提示菜单中总是将匹配项所在域信息显示在缩略信息最后一列。
" 0 : 信息缩略中不显示匹配项所在域(缺省)
" 1 : 显示匹配项所在域，并移除缩略信息中最后一列
let OmniCpp_ShowScopeInAbbr = 0

" 显示参数列表
let OmniCpp_ShowPrototypeInAbbr = 1

" 显示访问控制信息('+', '-', '#')
let OmniCpp_ShowAccess = 1

" 默认命名空间列表
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" 是否自动选择第一个匹配项。仅当"completeopt"不为"longest"时有效。
" 0 : 不选择第一项(缺省)
" 1 : 选择第一项并插入到光标位置
" 2 : 选择第一项但不插入光标位置
let OmniCpp_SelectFirstItem = 0

" 使用Vim标准查找函数/本地(local)查找函数
" Vim内部用来在函数中查找变量定义的函数需要函数括号位于文本的第一列
" 而本地查找函数并不需要。
let OmniCpp_LocalSearchDecl = 1

" 命名空间查找控制。
" 0 : 禁止查找命名空间
" 1 : 查找当前文件缓冲区内的命名空间(缺省)
" 2 : 查找当前文件缓冲区和包含文件中的命名空间
let OmniCpp_NamespaceSearch = 1

" C++ 成员引用自动补全
" 使用 NeoComplete 来 Handle
" let OmniCpp_MayCompleteDot = 1                  " 输入 . 后自动补全
" let OmniCpp_MayCompleteArrow = 1                " 输入 -> 后自动补全
" let OmniCpp_MayCompleteScope = 1                " 输入 :: 后自动补全

" 自动关闭补全窗口
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

" -----------------------------------------------------------------------------
" Jedi-vim
" -----------------------------------------------------------------------------
" python 补全

" 使用 NeoComplete 来 Handle
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0

" -----------------------------------------------------------------------------
" NeoComplete
" -----------------------------------------------------------------------------
" 关键字补全、文件路径补全、tag 补全等等
" 在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择效果比较好
" 需要 lua

" let g:acp_enableAtStartup = 0                       " 禁止内置自动补全
let g:neocomplete#enable_at_startup = 1             " 随 Vim 启动
let g:neocomplete#enable_smart_case = 1             " 只在输入大写字母时对大小写敏感
let g:neocomplete#auto_completion_start_length=4    " 只在输入超过四个字符时自动打开补全菜单
let g:neocomplete#sources#syntax#min_keyword_length = 4

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" 词段分割符
if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns.tex = ['{']

if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns.tex=
            \'\\\a{\a\{1,2}}'           .'\|'.
            \'\\[[:alpha:]@][[:alnum:]@]*\%({\%([[:alnum:]:_]\+\*\?}\?\)\?\)\?' .'\|'.
            \'\a[[:alnum:]:_-]*\*\?'

" 使用 omni completion.
if has('autocmd')
    au FileType css setlocal omnifunc=csscomplete#CompleteCSS
    au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    au Filetype java setlocal omnifunc=javacomplete#Complete
endif

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.java = '\%(\h\w*\|)\)\.\w*'

" Enable force omni completion.
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
au FileType python setlocal omnifunc=jedi#completions
let g:neocomplete#force_omni_input_patterns.python =
            \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" -----------------------------------------------------------------------------
" MultiCursor
" -----------------------------------------------------------------------------
" 同时使用多个光标编辑
" normal 模式下 ctrl-n 进行匹配，ctrl-p 跳过一个匹配项
" 在多个光标时使用 i 插入（会先报错，再按一次 i 即可插入）
" 在多个光标时使用 s 替换

" 防止与 NeoComplete 的冲突
" 先关闭 NeoComplete ，使用之后再重新打开 NeoComplete
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock') == 2
        exe 'NeoCompleteLock'
    endif
endfunction
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock') == 2
        exe 'NeoCompleteUnlock'
    endif
endfunction

" -----------------------------------------------------------------------------
" VimIM
" -----------------------------------------------------------------------------
" Vim 内的中文输入法

let g:Vimim_cloud = ''
" let g:Vimim_map = ''
" let g:Vimim_mode = 'dynamic'
" let g:Vimim_mycloud = 0
" let g:Vimim_shuangpin = 0
" let g:Vimim_toggle = ''

" 防止与 NeoComplete 的冲突
let g:Vimim_chinse_mode_on = 0
function! VIMIM_before()
    if exists(':NeoCompleteDisable') == 2
                \ && g:Vimim_chinse_mode_on == 0
        exe 'NeoCompleteLock'
        exe 'NeoCompleteDisable'
        let g:Vimim_chinse_mode_on = 1
    elseif exists(':NeoCompleteEnable') == 2
                \ && g:Vimim_chinse_mode_on == 1
        exe 'NeoCompleteUnlock'
        exe 'NeoCompleteEnable'
        let g:Vimim_chinse_mode_on = 0
    endif
endfunction

" 使用 ctrl-space 切换
imap <c-space> <c-o>:call VIMIM_before()<cr><c-\>
nmap <c-space> :call VIMIM_before()<cr><c-\>
let g:Vimim_map = 'c-bslash'

" 使用文中标点
let g:Vimim_punctuation = 2

" -----------------------------------------------------------------------------
" auto-pairs
" -----------------------------------------------------------------------------

" 关闭 fly mode （输入右括号跳到括号结束处）
let g:AutoPairsFlyMode = 0

" 在语句块之前输入要包围的符号，按 <leader>sr 将语句块包围
imap <Leader>sr <M-e>

" -----------------------------------------------------------------------------
" ctrlp
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区的检索插件
" 常规模式下输入：ctrl-p 调用插件

" -----------------------------------------------------------------------------
" emmet-vim
" -----------------------------------------------------------------------------
" HTML/CSS 代码快速编写神器

" -----------------------------------------------------------------------------
" NerdCommenter
" -----------------------------------------------------------------------------
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
nmap c] <Leader>cc
vmap c] <Leader>cc
nmap c[ <Leader>cu
vmap c[ <Leader>cu

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 F2 调用插件
" nmap <F2> :NERDTreeToggle<CR>

" -----------------------------------------------------------------------------
"  < surround 插件配置 >
" -----------------------------------------------------------------------------
" 快速给单词/句子两边增加符号（包括html标签），缺点是不能用"."来重复命令
" 不过 repeat 插件可以解决这个问题，详细帮助见 :h surround.txt

" -----------------------------------------------------------------------------
" ultisnips
" -----------------------------------------------------------------------------
" Snippet 插件
" 需要 python
" 使用 vim-snippets 中的 (La)TeX 的标题结构模板（如 cha, sec, etc.）时，需要
" pip install unicode

" Trigger configuration.
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
inoremap <c-j> <c-o>:echo 'Not in a snippet'<CR>
inoremap <c-k> <c-o>:echo 'Not in a snippet'<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" 添加自己的 snippets
" 当前路径是 $vimfiles
let g:UltiSnipsSnippetDirectories=["UltiSnips", "myVim/snippets"]

" ------------------------------------------------------------
" vim-markdown
" ------------------------------------------------------------

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" =============================================================================
" NOTES
" =============================================================================
" %		带路径的当前文件名
" %:h	文件路径.例如../path/test.c就会为../path
" %:t	不带路径的文件名.例如../path/test.c就会为test.c
" %:r	无扩展名的文件名.例如../path/test就会成为test
" %:e	扩展名

