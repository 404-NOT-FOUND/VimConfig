
set conceallevel=2

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ MyHiLink hi link <args>
else
  command! -nargs=+ MyHiLink hi def link <args>
endif

" 一级标题
syn match title ".*\n^\(=\s*\)\{3,}"
syn match title "^\(=\s*\)\{3,}"
" 二级标题
syn match title ".*\n^\(-\s*\)\{3,}"
syn match title "^\(-\s*\)\{3,}"
" 标题
syn match title "^#.*"

" syn match identifier "^>>>.*"

"syn match Include '\[[^]]*\]'

syn match Todo "\<def\>"

"syn match String '|\_[^|]*|' contains=myIgnore
syn match Error '{\_[^}]*} \?' contains=myIgnore

syn match myIgnore contained '|' conceal
syn match myIgnore contained '`' conceal
syn match myIgnore contained '{' conceal
syn match myIgnore contained '}' conceal cchar= 
syn match myIgnore contained '} ' conceal cchar= 
syn match myIgnore contained '>$' conceal

syn match Normal /'/

syn match Comment "%.*" contains=TODO,String,Error

syn match TODO "TODO" contained

"syn match String '>\(\n\(\t\| \{4}\| \{8}\).*\)\+' contains=DanglingCode
"syn match DanglingCode '^\(\t\| \{4}\| \{8}\).*' contains=myIgnore

syn region String	matchgroup=myIgnore start=" >$" start="^>$" end="^[^ \t]"me=e-1 end="<<<" concealends
syn region String	matchgroup=myIgnore start="|" end="|" concealends
syn region String	matchgroup=myIgnore start="`" end="`" concealends

" math zones
syn region Special	start="\$" end="\$" concealends
syn region Special	start="\\\[" end="\\\]" concealends

hi clear Conceal

