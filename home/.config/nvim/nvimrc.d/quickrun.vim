let s:bufname='[quickrun output]'
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
\    'outputter':                               'multi',
\    'outputter/multi/targets':                 ['buffer', 'error'],
\    'outputter/error/error':                   'quickfix',
\    'outputter/error/success':                 'null',
\    'outputter/buffer/opener':                 'botright 13new',
\    'outputter/buffer/bufname':                s:bufname,
\    'outputter/buffer/into':                   0,
\    'outputter/quickfix/open_cmd':             'copen 13',
\    'outputter/quickfix/into':                 0,
\    'hook/time/enable':                        1,
\    'runner':                                  'vimproc',
\    'runner/vimproc/updatetime':               500,
\    'hook/close_quickfix/enable_hook_loaded':  1,
\    'hook/close_quickfix/enable_success':      1,
\    'hook/close_buffer/enable_failure':        1,
\}

augroup quickrun
    autocmd!
    autocmd WinClosed * if bufname("%") == s:bufname | call quickrun#session#sweep() | fi
    autocmd VimLeave * call quickrun#session#sweep()
    autocmd Filetype quickrun nnoremap <buffer>q :bwipeout<CR>
    autocmd Filetype quickrun nnoremap <buffer><expr> <C-c> quickrun#session#exists() ? quickrun#session#sweep() : ":bwipeout<CR>"
    autocmd Filetype qf nnoremap <buffer>q :cclose<CR>
    " autocmd BufEnter * if (winnr("$") == 1) && bufname("%") == s:bufname | call quickrun#session#sweep() | quit | endif
augroup END