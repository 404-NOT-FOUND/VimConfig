
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

if g:islinux
  let $vimfiles="~/.vim"
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

    function! MyDiff()
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
source $vimfiles/colors/myColor.vimrc

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
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
else
    set runtimepath+=$vim/vimfiles/bundle/Vundle.vim
    call vundle#begin('$vim/vimfiles/bundle/')
endif

" 使用 Vundle 来管理 Vundle，必须要有
Plugin 'VundleVim/Vundle.vim'

" 以下为要安装或更新的插件

let g:use_VimIM = 0
if g:use_VimIM
    Plugin 'vim-scripts/VimIM'
endif

" Plugin 'Align'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'Mark--Karkat'
" Plugin 'Shougo/neocomplcache.vim'
" Plugin 'TxtBrowser'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'Yggdroot/indentLine'
" Plugin 'ZoomWin'
" Plugin 'a.vim'
" Plugin 'artur-shaik/vim-javacomplete2'
" Plugin 'bufexplorer.zip'
" Plugin 'cSyntaxAfter'
" Plugin 'ccvext.vim'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'ervandew/supertab'         " 有时与 snipmate 插件冲突
" Plugin 'exvim/ex-minibufexpl'      " exvim插件之一。修复BUG
" Plugin 'fholgado/minibufexpl.vim'  " 好像与 Vundle 插件有一些冲突
" Plugin 'javacomplete'
" Plugin 'jiangmiao/auto-pairs'
" Plugin 'majutsushi/tagbar'
" Plugin 'msanders/snipmate.vim'
" Plugin 'repeat.vim'
" Plugin 'scrooloose/nerdcommenter'
" Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/syntastic'
" Plugin 'shawncplus/phpcomplete.vim'
" Plugin 'std_c.zip'
" Plugin 'tomtom/tcomment_vim'
" Plugin 'vim-javacompleteex'
" Plugin 'wesleyche/SrcExpl'
Plugin 'OmniCppComplete'
Plugin 'justinmk/vim-sneak'
Plugin 'Shougo/neocomplete'
Plugin 'SirVer/ultisnips'
Plugin 'bkad/CamelCaseMotion'
Plugin 'christoomey/vim-sort-motion'
Plugin 'closetag.vim'
Plugin 'cohama/lexima.vim'           " auto pair closer
Plugin 'davidhalter/jedi-vim'        " python autocomplete. 'pip install jedi' required
Plugin 'grep.vim'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'lervag/vimtex'
Plugin 'mattn/emmet-vim'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'taglist.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'

call vundle#end()

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
    function! SetGuiFontSize(s)
        if g:iswindows
            exec 'set guifont=' . g:guifont . ':h' . string(a:s)
            exec 'set guifontwide=' . g:guifontwide . ':h' . string(a:s)
        else
            exec 'set guifont=' . g:guifont . '\ ' . string(a:s)
            exec 'set guifontwide=' . g:guifontwide . '\ ' . string(a:s-0.5)
        endif
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
set statusline+=[%{&fileformat}] " encoding
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

" 显示行号
set number
" 显示相对当前行的行号
set relativenumber

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

" 临时文件的位置。在 windows 下默认位置需要管理员权限。绕开
if g:iswindows
    let $TMP=$VIM . '\tmp'
endif

" 文本修改记录
set undofile
if g:iswindows
    set undodir=$TMP
endif

" cmd line 中的命令数记录
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 与 windows 共享剪贴板
set clipboard=unnamed

" 保存全局变量
set viminfo+=!

" 增强模式中的命令行自动完成操作
set wildmenu

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 每次命令行命令后告诉我们共更改了文件多少行内容
" 如 :s 之后会得到如 "3 substitutions on 1 line" 的提示
set report=0

" 修正 mswin 下 visual 操作问题
set selection=inclusive

" chinese input
" 需要编译时打开 +xim, +multi_byte_ime 或 global-ime 特性版本的 Vim
set noimcmdline
set imsearch=0
set iminsert=0
if has("autocmd")
  augroup chinese_input
    au InsertLeave * set iminsert=0 | set imsearch=0
    au CursorMoved * set iminsert=0 | set imsearch=0
  augroup END
endif

" =============================================================================
" 操作
" =============================================================================

" 不要使用 vi 的键盘模式，而是 vim 的
set nocompatible

" 在 cmd window 里使用 ESC 退出
" autocmd CmdWinEnter * inoremap <buffer><Esc> <C-o>:q<CR><Esc>

" 设置 leader 健
let g:mapleader = "\<Space>"

" 保存
" nnoremap <C-s> :update<CR>
" inoremap <C-s> <Esc>:update<CR>
nnoremap <Leader>s :update<CR>

" 使用 jk 退出到命令模式（同 Esc）
inoremap kj <Esc>

" 打开/关闭拼写检查
" (change option spell)
nmap cos :set spell!<CR>

" 使用 ctrl-y 重做 (redo)
" noremap <C-y> <C-r>

" 在命令行下使用 ctrl-v 粘贴
cmap <C-v> <C-r>+

" 删除所有行尾多余的空白（空格或 tab ）
nmap <F12>   :let g:winview = winsaveview()<CR>
            \:%s+\s\+$++e<CR>
            \:call histdel('search', -1)<CR>
            \/<UP><CR>
            \:nohls<CR>
            \:call winrestview(g:winview)<CR>
            \:echo 'Trialing spaces cleared'<CR>

" 取消搜索结果高亮
nmap <F11> :nohls<CR>

" ctrl-c 计算器
if has('python')
    imap <silent> <C-c> <C-r>=pyeval(input('Calculate: '))<CR>
else
    imap <silent> <C-c> <C-r>=string(eval(input("Calculate: ")))<CR>
endif

" 时间戳
" imap <Leader>time <c-r>=strftime("20%y-%m-%d")<cr>

" 将大写 Y 改成从光标位置复制到行尾以与大写 D 对应
nnoremap Y y$

" 使用 ]i 或 gni 移动到下一个相同缩进行
" 使用 [i 或 gpi 移动到前一个相同缩进行
" 使用 ]I 或 gnI 和 [I 或 gpI 移动到下/前一个比当前缩进浅一级的行
nnoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [I :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]I :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [i <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]i <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [I <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]I <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [i :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]i :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [I :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]I :call NextIndent(1, 1, 1, 1)<CR>

nnoremap <silent> gpi :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> gni :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> gpI :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> gnI :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> gpi <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> gni <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> gpI <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> gnI <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> gpi :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> gni :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> gpI :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> gnI :call NextIndent(1, 1, 1, 1)<CR>

" 使用方向键以在被折叠的行间移动
nnoremap <Up> gk
vnoremap <Up> gk
inoremap <Up> <C-o>gk
nnoremap <Down> gj
vnoremap <Down> gj
inoremap <Down> <C-o>gj

" 使回退键（backspace）正常跨行
set backspace=indent,eol,start

" 允许左右移动跨越行边界
" set whichwrap+=<,>,h,l

" 允许 ctrl-q 进入块选模式 (visual block mode)
" noremap <C-q> <C-v>

" 窗口控制
" " 使用 <Leader>. 和 <Leader>m 前后切换 Buffer
" nmap <silent> <Leader>. :bnext<CR>:buffers<CR>
" nmap <silent> <Leader>m :bprevious<CR>:buffers<CR>
nmap gb :ls<CR>:buffer<space>

" 使用 ctrl+j,k,h,l 切换分割的视窗
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" 标签控制
" 使用 ctrl+n 和 ctrl+x 打开/关闭标签
" nnoremap <C-n> :tabnew<CR>:e
" nnoremap <C-x> :tabc<CR>
" 使用 ctrl+Tab 切换标签
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>

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
set formatoptions=
set formatoptions+=coqjr    " 支持注释
set formatoptions+=n        " 支持列表，不要和 '2' 一起用
set formatoptions+=mB       " 方便中文文本操作
set formatoptions+=t
" 自动文本格式化的行宽
set textwidth=80

" 如下符号可以连接两个词
set iskeyword+=_,#

" =============================================================================
" Autocommands
" =============================================================================

if has("autocmd")

augroup my_autoformats
" 打开文件时定位至关闭时位置
au BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe " normal g`\"" |
            \ endif

" 将特殊后缀的文件设置为相应格式
au BufReadPost,BufNewFile *.mk setlocal filetype=markdown
au BufReadPost,BufNewFile *.notes setlocal filetype=notes
au BufReadPost,BufNewFile *.tex setlocal filetype=tex

" 为 txt 文件还原 TAB 长度
au BufReadPost *.txt setlocal tabstop=8
au BufReadPost *.txt setlocal shiftwidth=8
" au BufReadPost *.txt setlocal smarttab

" 注释风格
au BufReadPost *.sql set commentstring=--\ %s

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
" au FileType tex call SetMakeRunXeLaTeX()
au Filetype mp call SetMakeRunMpost()

" " 打开 tex 文件时自动打开相应的 pdf
" au VimEnter *tex call OpenTeXworks()
" au BufAdd   *tex call OpenTeXworks()

" " C-] 与 C-[ 注释
" au Filetype java,cpp,h,c call SetComments('c')
" au Filetype tex,mp call SetComments('tex')
" au Filetype vim,vimrc call SetComments('vim')

" 下列命令皆由 vim-surround 替代
" " 使用 z<Space> 在选中文本周围加上空格
" au BufReadPost * vnoremap z<Space> <Esc>:call WrapTextWith(' ', ' ')<CR>
" au BufReadPost * nmap z<Space> viwz<Space>
" " au BufReadPost * vnoremap z<Space> <Esc>`<i <Esc>`>a <Esc>

" " 使用 z(, z[, z{ 在选中文本周围加上括号
" au BufReadPost * vnoremap z( <Esc>:call WrapTextWith('(', ')')<CR>
" au BufReadPost * nmap z( viwz(
" au BufReadPost * vnoremap z[ <Esc>:call WrapTextWith('[', ']')<CR>
" au BufReadPost * nmap z[ viwz[
" au BufReadPost * vnoremap z{ <Esc>:call WrapTextWith('{', '}')<CR>
" au BufReadPost * nmap z{ viwz{
" " au BufReadPost * vnoremap z( <Esc>`<i <Esc>r(`>a <Esc>r)<Esc>

" " 使用 z", z', z` 在选中文本周围加上引号
" au BufReadPost * vnoremap z" <Esc>:call WrapTextWith('"', '"')<CR>
" au BufReadPost * nmap z" viwz"
" au BufReadPost * vnoremap z' <Esc>:call WrapTextWith("'", "'")<CR>
" au BufReadPost * nmap z' viwz'
" au BufReadPost * vnoremap z` <Esc>:call WrapTextWith('`', '`')<CR>
" au BufReadPost * nmap z` viwz`

" " 使用 zm 将选中文本包围在一对 $ 中 (LaTeX math mode)
" au BufReadPost *.tex vnoremap zm <Esc>:call WrapTextWith('$', '$')<CR>
" au BufReadPost *.tex nmap zm viwzm
" " au BufReadPost *.tex,*.notes vnoremap zm <Esc>`<i$<Esc>`>a$<Esc>

" " 使用 ze 强调文本
" au BufReadPost *.notes vnoremap ze <Esc>:call WrapTextWith('\|', '\|')<CR>
" au BufReadPost *.{md,mdown,mkd,mkdn,markdown,mdwn,mk}
"             \ vnoremap ze <Esc>:call WrapTextWith('*', '*')<CR>
" au BufReadPost *.notes vnoremap ze <Esc>`<i\|<Esc>`>a\|<Esc>
" au BufReadPost *.markdown vnoremap ze <Esc>`<i*<Esc>`>a*<Esc>
" au BufReadPost *.notes,*.{md,mdown,mkd,mkdn,markdown,mdwn,mk}
"             \ nmap ze viwze

" " 根据文件格式显示行号
" au FileType xml,html,c,S,cs,java,perl,shell,bash,cpp,python,vim,php,ruby,tex,mp
"       \ setlocal number
" au FileType xml,html,c,S,cs,java,perl,shell,bash,cpp,python,vim,php,ruby,tex,mp
"       \ setlocal relativenumber

" 制作标签
au FileType cpp,h setlocal tags+=$vimfiles/myVim/cppTags
au FileType java setlocal tags+=$vimfiles/myVim/javaTags
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

" 识别 LaTeX 嵌入文本
" au FileType tex let &l:include = '^[^%]*\(\\input\>\|\\include\>\|\\includegraphics\(\[.\{-}\]\)\?\)'
" au FileType tex setlocal suffixesadd=.tex

" markdown preview (需要 CHROME 并装有 markdown preview plus 插件)
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}
            \ map <Leader>p :silent ! start chrome --new-window "%:p"<CR>

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

augroup END
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
  nmap <buffer> <C-S-F5> :call CompileRunMpost()<CR>
  nmap <buffer> <C-CR> :call RunMpost()<CR>
"         \ :texworks 'silent !%<-' .
"         \ input('Open figure number: ') . '.pdf'<CR>
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

" " XeLaTeX 的编译与运行
" func! SetMakeRunXeLaTeX()
" "  if g:iswindows
" "    exec 'silent !if exist %<.pdf (start texworks %<.pdf)'
" "  else
" "    exec 'silent !if [ -e %<.pdf ]; then start texworks %<.pdf; fi'
" "  endif
"   nmap <buffer> <F5> :call CompileXeLaTeX()<CR>
"   nmap <buffer> <C-F5> :call CompileRunXeLaTeX()<CR>
"   nmap <buffer> <C-CR> :call TeXclean()<CR>:silent !%<.pdf ^&<CR>
" endfunc
" func! OpenTeXworks()
"   if g:iswindows
"     exec 'silent !if exist <afile><.pdf (start <afile><.pdf)'
"   else
"     exec 'silent !if [ -e <afile><.pdf ]; then start <afile><.pdf; fi'
"   endif
" endfunc
" func! CompileXeLaTeX()
"   exec "!xelatex %"
" endfunc
" func! CompileRunXeLaTeX()
"   exec "w"
"   exec "silent !xelatex -quiet %"
"   exec "silent !xelatex -quiet %"
"   call TeXclean()
"   exec "silent !%:r.pdf ^&"
" endfunc

" ------------------------------------------------------------

" Java 的编译与运行
func! SetMakeRunJavac()
  :set makeprg=javac\ %
  nmap <buffer> <F5> :call MakeRunJava()<CR>
  nmap <buffer> <C-CR> :!java %<<CR>
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
  nmap <buffer> <C-CR> :!%<.exe<CR>
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
"   if a:char == 'c'
"     map c] :s+^\(\s*[^ \t]\)+// \1+ge<CR>
"           \/<Up><Up><CR><C-o>
"           \:nohls<CR>
"           \:echo "comments added"<CR>
"
"     map c[ :s+^\(\s*\)// +\1+ge<CR>
"           \/<Up><Up><CR><C-o>
"           \:nohls<CR>
"           \:echo "comments removed"<CR>
"
"   elseif a:char == 'tex'
"     map c] :s+^+% +ge<CR>:nohls<CR>:echo "comments added"<CR>
"     map c[ :s+^\(\s*\)%[ ]*+\1+ge<CR>:nohls<CR>:echo "comments removed"<CR>
"   elseif a:char == 'vim'
"     map c] :s+^+" +ge<CR>:nohls<CR>:echo "comments added"<CR>
"     map c[ :s+^\(\s*\)"[ ]*+\1+ge<CR>:nohls<CR>:echo "comments removed"<CR>
"   endif
" endfunc

" ------------------------------------------------------------
" 包围选中的文本

" func! WrapTextWith(left, right)
"   exe "norm `<i \<Esc>r".a:left."`>la \<Esc>r".a:right
" endfunc

" ------------------------------------------------------------
" 将文件 <EOL> 改为 UNIX 格式

func! UnixEOL()
  e ++ff=dos | setlocal ff=unix | update
  exe "%s+\r++ge"
endfunc

" ------------------------------------------------------------

" 自动折叠函数和大段注释
" func! FoldBrace(int)
"   " functions
"   if getline(v:lnum) =~ ')'  " make sure it's a function
"     " '{' could be on the second line
"     if getline(v:lnum+1)[a:int] == '{'
"       return 1
"     endif
"     " or the same line as the definition
"     if getline(v:lnum) =~ '{' && !(getline(v:lnum) =~ '}')
"       return 1
"     endif
"   endif
"   " look for '}' and not '};' since a func def can't end with it
"   if getline(v:lnum)[a:int] == '}' && !(getline(v:lnum) =~ '};')
"     return '<1'
"   endif
"   " block comments
"   if getline(v:lnum-1) =~ '/\*' && !(getline(v:lnum) =~ '\*/')
"         \ && !(getline(v:lnum+1) =~ '\*/')
"     return 2
"   endif
"   if getline(v:lnum+1) =~ '\*/'
"     return '<2'
"   endif
"   " default
"   return -1
" endfunc

" 自动补全括号
" func! CompleteBrackets()
"   inoremap <buffer> ( ()<Left>
"   inoremap <silent> <buffer> ) <C-r>=ClosePair(')')<CR>
"   inoremap <buffer> { {}<Left>
"   inoremap <silent> <buffer> } <C-r>=ClosePair('}')<CR>
"   inoremap <buffer> [ []<Left>
"   inoremap <silent> <buffer> ] <C-r>=ClosePair(']')<CR>
"   " inoremap <buffer> " ""<Left>
"   " inoremap <buffer> ' ''<Left>
"   inoremap <buffer> <CR> <C-r>=MultilineBrackets()<CR>
" endfunc
" " 实现括号的自动配对后防止重复输入
" function! ClosePair(char)
"   if getline('.')[col('.') - 1] == a:char
"     return "\<Right>"
"   else
"     return a:char
"   endif
" endf
" func! MultilineBrackets()
"   echo getline('.')[col('.') - 2]
"   echo getline('.')[col('.') - 1]
"   if    ( getline('.')[col('.') - 2] == '(' && getline('.')[col('.')-1] == ')' )
"         \ || ( getline('.')[col('.') - 2] == '[' && getline('.')[col('.')-1] == ']' )
"         \ || ( getline('.')[col('.') - 2] == '{' && getline('.')[col('.')-1] == '}' )
"     return "\r\<Esc>\<S-o>"
"   else
"     return "\r"
"   endif
" endfunc

" ------------------------------------------------------------

" 使用 Vim[grep] 来 grep
function! MyQuickGrep()
  let pattern = input('Search for pattern: ')
  let filename = input('Search in files: ')
  exe 'redraw'

  if (pattern == '')
    echohl WarningMsg | echo 'Please enter a search pattern' | echohl None
    exe "normal \<Esc>"
  elseif (filename == '')
    "echohl WarningMsg | echo 'Please enter filename(s)' | echohl None
    "exe "normal \<Esc>"
    let filename = '*'
  endif
  try
    exe 'vimgrep /' . pattern . '/j ' . filename . '|copen'
    " j option inhibits jumping to search results
    " open quickfix for result browsing
  endtry
endfunction

" ------------------------------------------------------------

" 根据缩进来移动
" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool)  : Motion is exclusive?
" fwd (bool)        : Go to next / previous line
" lowerlevel (bool) : Go to line with lower / same indentation level
" skipblanks (bool) : Skip blank lines?
func! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
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
  augroup chinse_quick_fix
    au QuickfixCmdPost make call QfMakeConv()
    func! QfMakeConv()
      let qflist = getqflist()
      for i in qflist
        let i.text = iconv(i.text, "cp936", "utf-8")
      endfor
      call setqflist(qflist)
      exec "cw"
    endfunc
  augroup END
endif

" -----------------------------------------------------------------------------
" TagList & Ctags
" -----------------------------------------------------------------------------
" 对于C++代码，ctags需要额外使用以下选项：
" 为标签添加函数原型(prototype)信息
" --c++-kinds=+p
" 为标签添加继承信息(inheritance)，访问控制(access)信息，
" 函数特征(function Signature,如参数表或原型等)
" --fields=+iaS
" 为类成员标签添加类标识
" --extra=+q
set tags=tags

" 配置 TagList 的 ctags 路径
let Tlist_Ctags_Cmd = "%VIMRUNTIME%\\ctags.exe"

" 按照名称排序
let Tlist_Sort_Type = "name"

" 压缩方式
" let Tlist_Compart_Format = 1

" 如果 taglist 窗口是最后一个窗口，则退出 vim
let Tlist_Exist_OnlyWindow = 1

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 1

" 让当前不被编辑的文件的方法列表自动折叠起来
let Tlist_File_Fold_Auto_Close = 0

let Tlist_Show_One_File = 0

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
if has("autocmd")
  augroup auto_close_completion
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
  augroup END
endif
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
" 在弹出补全列表后用 <C-p> 或 <C-n> 进行上下选择效果比较好
" 需要 lua

" let g:acp_enableAtStartup = 0                       " 禁止内置自动补全
let g:neocomplete#enable_at_startup = 1             " 随 Vim 启动
let g:neocomplete#enable_smart_case = 1             " 只在输入大写字母时对大小写敏感
let g:neocomplete#auto_completion_start_length=3    " 只在输入超过三个字符时自动打开补全菜单
let g:neocomplete#sources#syntax#min_keyword_length = 4
" 默认情况下，在 NeoComplete 补全时按下退格键会撤销补全。这里改为应用补全并删去
" 一个字符
inoremap <expr><C-h> neocomplete#close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#close_popup()."\<C-h>"

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

if g:use_VimIM
  " 使用 ctrl-space 打开 / 关闭 VimIM
  inoremap <C-Space> <Space><Esc>:call VIMIM_before()<CR>s<C-r>=g:Vimim_chinese()<CR>
  nnoremap <C-Space> :call VIMIM_before()<CR>a<C-r>=g:Vimim_chinese()<CR><Esc>
endif

" 使用文中标点
let g:Vimim_punctuation = 3

" -----------------------------------------------------------------------------
" closetag - 一键关闭 HTML 标签
" -----------------------------------------------------------------------------

" set up mappings for tag closing
inoremap <C-_> <C-r>=GetCloseTag()<CR>
nnoremap <C-_> a<C-r>=GetCloseTag()<CR><Esc>

" -----------------------------------------------------------------------------
" auto-pairs
" -----------------------------------------------------------------------------

" 关闭 fly mode （输入右括号跳到括号结束处）
let g:AutoPairsFlyMode = 0

" 在语句块之前输入要包围的符号，按 <leader>sr 将语句块包围
" imap <Leader>sr <M-e>

" 将输入闭括号自动跳过下一个紧接的闭括号的功能限制在当前行内
let g:AutoPairsMultilineClose = 0

" -----------------------------------------------------------------------------
" lexima
" -----------------------------------------------------------------------------

imap <C-h> <BS>
cmap <C-h> <BS>

try
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '{\%#}',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '<CR>', 'at': '\[\%#]',
        \  'input' : '%<CR>', 'input_after': '<CR>',
        \  'filetype' : 'tex',
        \ })
  call lexima#add_rule({
        \  'char': '``',
        \  'input_after': "''",
        \  'filetype' : 'tex',
        \ })
catch
endtry

" -----------------------------------------------------------------------------
" ctrlp
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区的检索插件
" 常规模式下输入：ctrl-p 调用插件

" -----------------------------------------------------------------------------
" emmet-vim
" -----------------------------------------------------------------------------
" HTML/CSS 代码快速编写神器

" make emmet only work in html and css files
let g:user_emmet_install_global = 0
if has('autocmd')
  augroup install_emmet
    au FileType html,css EmmetInstall
  augroup END
endif

let g:user_emmet_leader_key='<C-e>'

" -----------------------------------------------------------------------------
" NerdCommenter
" -----------------------------------------------------------------------------
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
" let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
" nmap c] <Leader>cc
" vmap c] <Leader>cc
" nmap c[ <Leader>cu
" vmap c[ <Leader>cu

" -----------------------------------------------------------------------------
" commentary
" -----------------------------------------------------------------------------

" map cm <Plug>Commentary
" "map cml <Plug>CommentaryLine
" map cic <Plug>ChangeCommentary
" map cac <Plug>ChangeCommentary
" map cmu <Plug>Commentary<Plug>Commentary " uncomment a block of comments

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录村结构的文件浏览插件

" 常规模式下输入 F2 调用插件
" nmap <F2> :NERDTreeToggle<CR>

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
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" ------------------------------------------------------------
" vim-markdown
" ------------------------------------------------------------

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'sql', 'java', 'c', 'ocaml']
let g:markdown_syntax_conceal = 0

" ------------------------------------------------------------
" reftex
" ------------------------------------------------------------
" 在 LaTeX 中引用时给出 label 列表

" if has('autocmd')
"   augroup ennable_reftex
"     au BufReadPost *.tex source $vim/vimfiles/ftplugin/reftex.vim
"     au FileType tex source $vim/vimfiles/ftplugin/reftex.vim
"   augroup END
" endif

" ------------------------------------------------------------
" vimtex
" ------------------------------------------------------------

" use latexmk to compile LaTeX docs, require perl installed on machine

let g:tex_flavor                          = 'latex'
let g:tex_indent_items                    = 1
let g:Tex_DefaultTargetFormat             = 'pdf'
let g:Tex_CompileRule_pdf                 = '-xelatex -shell-escape -src-specials -synctex=1 -interaction=nonstopmode'
let g:Tex_FormatDependency_pdf            = 'pdf'
let g:vimtex_view_method                  = 'general'
let g:vimtex_enabled                      = 1
let g:vimtex_complete_img_use_tail        = 1
let g:vimtex_latexmk_options              = g:Tex_CompileRule_pdf
if g:iswindows
  " use SumatraPDF to view PDF, SumatraPDF required
  let g:vimtex_view_general_viewer          = 'SumatraPDF'
  let g:vimtex_view_general_options         = '-reuse-instance -forward-search @tex @line @pdf'
  let g:vimtex_view_general_options_latexmk = '-reuse-instance'
else
  let g:vimtex_view_general_viewer          = 'xdg-open'
endif

" list of modifiers of pairs / delimiters to toggle
let g:vimtex_delim_toggle_mod_list = [
      \ ['\bigl', '\bigr'],
      \ ['\Bigl', '\Bigr'],
      \ ['\biggl', '\biggr'],
      \ ['\Biggl', '\Biggr'],
      \]
"       \ ['\left', '\right'],

" make neocomplete support citation / label ref / ... completions
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
      \ '\v\\%('
      \ . '\a*%(ref|cite)\a*%(\s*\[[^]]*\])?\s*\{[^{}]*'
      \ . '|includegraphics%(\s*\[[^]]*\])?\s*\{[^{}]*'
      \ . '|%(include|input)\s*\{[^{}]*'
      \ . ')'

" ------------------------------------------------------------
" LaTeX-Box
" ------------------------------------------------------------

" use latexmk to compile LaTeX docs, require perl installed on machine

" let g:LatexBox_latexmk_options = "-pdflatex='xelatex -synctex=1'"
" let g:LatexBox_latexmk_async   = 0
" let g:LatexBox_latexmk_options = "-pdflatex=xelatex"
" let g:LatexBox_latexmk_async   = 0
" let g:LatexBox_latexmk_async   = 1

" ------------------------------------------------------------
" vim-easy-align
" ------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------
" CamelCaseMotion
" ------------------------------------------------------------

" jump among words IN CAMEL CASE OR SNAKE STYLE NAMES
" e.g., [C]amelCase ----> Camel[C]ase
nmap <silent> <Leader>w <Plug>CamelCaseMotion_w
nmap <silent> <Leader>b <Plug>CamelCaseMotion_b
nmap <silent> <Leader>e <Plug>CamelCaseMotion_e
nmap <silent> <Leader>ge <Plug>CamelCaseMotion_ge
omap <silent> <Leader>w <Plug>CamelCaseMotion_w
omap <silent> <Leader>b <Plug>CamelCaseMotion_b
omap <silent> <Leader>e <Plug>CamelCaseMotion_e
omap <silent> <Leader>ge <Plug>CamelCaseMotion_ge
xmap <silent> <Leader>w <Plug>CamelCaseMotion_w
xmap <silent> <Leader>b <Plug>CamelCaseMotion_b
xmap <silent> <Leader>e <Plug>CamelCaseMotion_e
xmap <silent> <Leader>ge <Plug>CamelCaseMotion_ge

" CamelCase text objects
omap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
xmap <silent> i<Leader>w <Plug>CamelCaseMotion_ie
omap <silent> i<Leader>b <Plug>CamelCaseMotion_ib
xmap <silent> i<Leader>b <Plug>CamelCaseMotion_ib
omap <silent> a<Leader>w <Plug>CamelCaseMotion_ie
xmap <silent> a<Leader>w <Plug>CamelCaseMotion_ie
omap <silent> a<Leader>b <Plug>CamelCaseMotion_ib
xmap <silent> a<Leader>b <Plug>CamelCaseMotion_ib

" ------------------------------------------------------------
" surround
" ------------------------------------------------------------

" quotes
let g:surround_{char2nr("q")} = "'\r'"
let g:surround_{char2nr("Q")} = "\"\r\""
if has("autocmd")
  augroup surround_keymaps
    au Filetype tex let g:surround_{char2nr("q")} = "`\r'"
    au Filetype tex let g:surround_{char2nr("Q")} = "``\r''"
    au Filetype tex let g:surround_{char2nr("f")} = "\\\1command: \1{\r}"
    au Filetype tex,markdown let g:surround_{char2nr("m")} = "$\r$"
    au Filetype tex,markdown let g:surround_{char2nr("M")} = "\\[\n\t\r\n\\]"

    " code
    au Filetype markdown let g:surround_{char2nr("c")}
          \ = "```\1language: \1 \n\r\n```"

    " emph
    au Filetype markdown let g:surround_{char2nr("e")}
          \ = "*\r*"
    au Filetype markdown let g:surround_{char2nr("E")}
          \ = "**\r**"
    au Filetype notes let g:surround_{char2nr("e")}
          \ = "\|\r\|"
  augroup END
endif

" ------------------------------------------------------------
" sneak
" ------------------------------------------------------------

" let g:sneak#label = 1

" =============================================================================
" 编码配置
" =============================================================================

" 注：使用 utf-8 格式后，软件与程序源码、文件路径不能有中文，否则报错
" 设定新文件使用的解码
set encoding=utf-8
set fileencoding=utf-8
" 设置支持打开的文件的编码
set fileencodings=utf-8,cp936,utf-16le,usc-bom,gbk,euc-jp,chinese,gb18030,ucs,gb2312,big5

" 设置支持的 <EOL> 格式
set fileformats=unix
" 设置新文件的 <EOL> 格式
set fileformat=unix

" 将程序语言设为英文
" 设置信息语言
let $LANG='en_US.utf-8'
" 设置菜单语言
set langmenu=en

" 设置拼写检查语言为美式英语
set spelllang=en_us
" 使拼写检查忽略东亚字符
set spelllang+=cjk

" NOTES
" =============================================================================
" %		带路径的当前文件名
" %:h	文件路径.例如../path/test.c就会为../path
" %:t	不带路径的文件名.例如../path/test.c就会为test.c
" %:r	无扩展名的文件名.例如../path/test就会成为test
" %:e	扩展名

