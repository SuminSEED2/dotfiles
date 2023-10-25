set expandtab                       " tab入力をスペースにする
set tabstop=4                       " tab文字の表現
set softtabstop=4                   " 連続したスペースの扱い
set smarttab
set shiftwidth=4                    " 自動インデント数

set autoindent
set smartindent
set cindent

autocmd FileType yaml setlocal sw=2 sts=2 ts=2
