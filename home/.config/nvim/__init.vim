let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim/bin/python'
let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python'

let g:coc_global_extensions = [
    \'coc-css',
    \'coc-eslint',
    \'coc-html',
    \'coc-json',
    \'coc-tsserver',
    \'coc-vimlsp',
    \'coc-clangd',
    \'coc-lists',
    \'coc-swagger',
    \'coc-spell-checker',
    \'coc-restclient',
    \'coc-jedi',
    \'coc-metals',
    \'coc-vetur',
\]

call plug#begin('~/.local/share/nvim/plugged')
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        " Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'flazz/vim-colorschemes'
    Plug 'lithammer/vim-eighties'
    Plug 'whatyouhide/vim-gotham'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'vim-jp/vimdoc-ja'
    Plug 'Shougo/vimproc.vim', { 'do': 'make' }
        Plug 'thinca/vim-quickrun'
            Plug 'osyo-manga/shabadou.vim'
    Plug 'tpope/vim-surround'
    Plug 'tomtom/tcomment_vim'
    Plug 'skanehira/translate.vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'puremourning/vimspector'
    Plug 'junegunn/vim-easy-align'
    Plug 'rhysd/committia.vim'
    Plug 'lifepillar/vim-solarized8'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'posva/vim-vue'

call plug#end()

filetype plugin indent on

let g:NERDTreeLinitedSyntax = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeChDirMode = 2
let g:NERDTreeBookmarksFile = "$HOME/.vim"

runtime! nvimrc.d/*.vim

"augroup start
"    autocmd!
"    autocmd StdinReadPre * let s:std_in=1
"    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'cd '.argv()[0] | exe 'NERDTree' argv()[0] | wincmd p | ene | NERDTreeFocus | endif
"    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"augroup END
