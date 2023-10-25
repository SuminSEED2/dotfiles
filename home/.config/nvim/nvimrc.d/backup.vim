set patchmode=                      " オリジナルファイルを作らない
set noautowrite                     " 自動保存無効
set backup                        " バックアップファイルを作る
set writebackup                     " ファイルの書き込みに成功したときバックアップファイルを削除する
set undofile                        " undoファイル生成
set swapfile                        " swapファイル生成
set updatetime=300                 " この時間の間 (ミリ秒単位) 入力がなければスワップファイルがディスクに書き込まれる
" set updatecount=200                 " この時間の間 (ミリ秒単位) 入力がなければスワップファイルがディスクに書き込まれる
set undodir=~/.config/nvim/tmp/undo
set directory=~/.config/nvim/tmp/swap
set backupdir=~/.config/nvim/tmp/backup
