return {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        opts = {
            -- enable = true,
            -- additional_vim_regex_highlighting = false
            ensure_installed = 'all',
            highlight = {
                enable = true,
                disable = { "csv" }

                -- Treesitter + tcomment の組み合わせで vue ファイルでのコメントアウトがうまく動くまで必要
                -- disable = { "vue" }
                -- english
            },
        },
        config = function(_, opts) 
            require'nvim-treesitter.configs'.setup(opts)
        end
    },
    {
        'nvim-tree/nvim-web-devicons',
        opts = {},
        config = function(_, opts)
            require("nvim-web-devicons").setup(opts)
        end
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        config = function(_, opts)
            require("Comment").setup(opts)
        end
    },
    {
        'kylechui/nvim-surround',
        opts = {},
        config = function(_, opts)
            require("nvim-surround").setup(opts)
        end
    },
    'ryanoasis/vim-devicons',
    'editorconfig/editorconfig-vim',
    'junegunn/vim-easy-align',
    'rhysd/committia.vim',
    'skanehira/translate.vim',

    -- けせ
    'scrooloose/nerdtree',
    {
        'tiagofumo/vim-nerdtree-syntax-highlight',
        requires = { 'scrooloose/nerdtree' }
    }
}
