let mapleader = "\<Space>"                 " キーマップリーダー

noremap <Leader><CR> :source $MYVIMRC<CR>

" Tagbar
nnoremap <F8> :TagbarToggle<CR>

" NERDTree
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeToggle<CR>

" QuickRun
" nnoremap <F5> :QuickRun -mode n<CR>
" vnoremap <F5> :QuickRun -mode v<CR>
noremap <Leader>q :QuickRun -mode n<CR>
vnoremap <Leader>q :QuickRun -mode v<CR>

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" terminal
tnoremap <silent> <ESC> <C-\><C-n>

"translate
vmap <Leader>h <Plug>(VTranslate)

"rest-client
vmap <Leader>r :CocCommand rest-client.request <cr>

noremap <Leader>y "*y
noremap <Leader>Y "*Y
noremap <Leader>p "*p
noremap <Leader>P "*P
noremap <Leader>d "*d
noremap <Leader>D "*D

nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap ^ g^
nnoremap g^ ^
nnoremap 0 g0
nnoremap g0 0
" nnoremap $ g$
nnoremap g$ $