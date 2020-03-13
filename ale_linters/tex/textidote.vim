" Author: Jordi Altayo <jordiag@kth.se>
" Description: support for textidote grammar and syntax checker

let g:ale_tex_textidote_executable = 'textidote'
let g:ale_tex_textidote_options = '--output singleline'

function! ale_linters#tex#textidote#Handle(buffer, lines) abort
    let l:pattern = '.*' . expand('%:t:r') . '\.tex(L\(\d\+\)C\(\d\+\)-L\d\+C\d\+): \(.*\)".*"'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[1] + 0,
        \   'col' : l:match[2] + 0,
        \   'text': l:match[3],
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('tex', {
\   'name': 'textidote',
\   'output_stream': 'stdout',
\   'executable': 'textidote',
\   'command': 'textidote --no-color --output singleline ' . expand('%'),
\   'callback': 'ale_linters#tex#textidote#Handle',
\})
