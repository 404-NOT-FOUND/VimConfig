" Vim filetype plugin
" Language:	LaTeX
" this code is directly from Carl Mueller's auctex.vim (with minor mods)
" http://www.vim.org/scripts/script.php?script_id=162

inoremap <buffer><silent> <Insert> <C-R>=<SID>TexInsertTabWrapper()<CR>

function! s:TexInsertTabWrapper() 

    let line = getline('.')
    let column = col('.') - 1

    " Check to see if you're between brackets in \ref{} or \cite{}.
    " Inspired by RefTex.
    " Typing q returns you to editing
    " Typing <CR> or Left-clicking takes the data into \ref{} or \cite{}.
    " Within \cite{}, you can enter a regular expression followed by <Tab>,
    " Only the citations with matching authors are shown.
    " \cite{c.*mo<Tab>} will show articles by Mueller and Moolinar, for example.
    " Once the citation is shown, you type <CR> anywhere within the citation.
    " The bibtex files listed in \bibliography{} are the ones shown.
    if strpart(line,column-15,15) =~ '.\{-}\\\a*ref{'
        let name = bufname(1)
        let short = substitute(name, ".*/", "", "")
        let aux = strpart(short, 0, strlen(short)-3)."aux"
        if filereadable(aux)
            let tmp = tempname()
            execute "below split ".tmp
            execute "0read ".aux
            g!/^\\newlabel{/delete
            g/^\\newlabel{tocindent/delete
            g/./normal 3f{lyt}0Pf}D0f\cf{       
            execute "write! ".tmp

            noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>RefInsertion("aux")<CR>a
            noremap <buffer> <CR> :call <SID>RefInsertion("aux")<CR>a
            noremap <buffer> q :bwipeout!<CR>zzi
            return "\<Esc>"
        else
            let tmp = tempname()
            vertical 15split
            execute "write! ".tmp
            execute "edit ".tmp
            g!/\\label{/delete
            %s/.*\\label{//e
            %s/}.*//e
            noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>RefInsertion("")<CR>a
            noremap <buffer> <CR> :call <SID>RefInsertion("")<CR>a
            noremap <buffer> q :bwipeout!<CR>zzi
            return "\<Esc>"
        endif
    elseif strpart(line,column-10,10) =~ '.\{-}\\\a*cite{'
        let tmp = tempname()
        execute "write! ".tmp
        execute "split ".tmp

        if 0 != search('\\begin{thebibliography}')
            bwipeout!
            execute "below split ".tmp
            call search('\\begin{thebibliography}')
            normal kdgg
            noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>CiteInsertion('\\bibitem')<CR>a
            vnoremap <buffer> <RightRelease> <C-c><Left>:call <SID>CommaCiteInsertion('\\bibitem')<CR>
            noremap <buffer> <CR> :call <SID>CiteInsertion('\\bibitem')<CR>a
            noremap <buffer> , :call <SID>CommaCiteInsertion('\\bibitem')<CR>
            noremap <buffer> q :bwipeout!<CR>f}zzi
            return "\<Esc>"
        else
            let l = search('\\bibliography{')
            bwipeout!
            if l == 0
                return ''
            else
                let s = getline(l)
                let beginning = matchend(s, '\\bibliography{')
                let ending = matchend(s, '}', beginning)
                let f = strpart(s, beginning, ending-beginning-1)
                let tmp = tempname()
                execute "below split ".tmp
                let file_exists = 0

                let name = bufname(1)
                let base = substitute(name, "[^/]*$", "", "")
                while f != ''
                    let comma = match(f, ',[^,]*$')
                    if comma == -1
                        let file = base.f.'.bib'
                        if filereadable(file)
                            let file_exists = 1
                            execute "0r ".file
                        endif
                        let f = ''
                    else
                        let file = strpart(f, comma+1)
                        let file = base.file.'.bib'
                        if filereadable(file)
                            let file_exists = 1
                            execute "0r ".file
                        endif
                        let f = strpart(f, 0, comma)
                    endif
                endwhile

                noremap <buffer> <LeftRelease> <LeftRelease>:call <SID>CiteInsertion("@")<CR>a
                vnoremap <buffer> <RightRelease> <C-c><Left>:call <SID>CommaCiteInsertion("@")<CR>
                noremap <buffer> <CR> :call <SID>CiteInsertion("@")<CR>a
                noremap <buffer> , :call <SID>CommaCiteInsertion("@")<CR>
                noremap <buffer> q :bwipeout!<CR>zzi
                return "\<Esc>"

            endif
        endif
    else
        return "\<Insert>" 
    endif
endfunction

" Inspired by RefTex
function! s:RefInsertion(x)
    if a:x == "aux"
        normal 0Wy$
    else
        normal 0y$
    endif
    bwipeout!
    let thisline = getline('.')
    let thiscol  = col('.')
    if thisline[thiscol-1] == '{'
        normal p
    else
        normal Pl
    endif
    if thisline[thiscol] == ')'
        normal l
    endif
endfunction

" Inspired by RefTex
" Get one citation from the .bib file or from the bibitem entries.
function! s:CiteInsertion(x)
    +
    "if search('@','b') != 0
    if search(a:x, 'b') != 0
        if a:x == "@"
            normal f{lyt,
        else
            normal f{lyt}
        endif
        bwipeout!
        normal Pf}
    else
        bwipeout!
    endif
endfunction

" Inspired by RefTex
" Get one citation from the .bib file or from the bibitem entries
" and be ready to get more.
function! s:CommaCiteInsertion(x)
    +
    if search(a:x, 'b') != 0
        if a:x == "@"
            normal f{lyt,
        else
            normal f{lyt}
        endif
        normal Pa,f}
    else
        bwipeout!
    endif
endfunction

