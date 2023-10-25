vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use "wbthomason/packer.nvim"
    use { 'scalameta/nvim-metals', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            "nvim-lua/plenary.nvim",
            'nvim-telescope/telescope-fzf-native.nvim'
        },
        config = function()
            local telescope = require('telescope') 
            local builtin = require('telescope.builtin') 
            local actions = require('telescope.actions') 
            telescope.setup({
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                },
                defaults = {
                    mappings = {
                        i = {
                            ["<C-u>"] = false
                        },
                        n = {
                            ["<C-c>"] = actions.close
                        }
                    }
                }
            })
            telescope.load_extension('fzf')
            -- vim.keymap.set('n', '<Leader>zca', builtin.lsp_type_definitions, {})
            -- vim.keymap.set('n', '<Leader>zca', builtin.lsp_type_definitions, {})
            vim.keymap.set('n', '<Leader>zca', builtin.diagnostics, {})
            -- require('telescope').setup({
            --     defaults = {
            --         -- Default configuration for telescope goes here:
            --         -- config_key = value,
            --         mappings = {
            --             i = {
            --                 -- map actions.which_key to <C-h> (default: <C-/>)
            --                 -- actions.which_key shows the mappings for your picker,
            --                 -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            --                 ["<C-u>"] = "<C-u>"
            --             }
            --         }
            --     }
            -- })
        end,
    }
    use {
    
        -- 'tomtom/tcomment_vim',
        'scrooloose/nerdtree',
    
    
        "mfussenegger/nvim-dap"
    }
    
    
    use { 'tiagofumo/vim-nerdtree-syntax-highlight', requires = { 'scrooloose/nerdtree' } }
    use { 'junegunn/fzf.vim', requires = {
        use { 'junegunn/fzf', run = ":call fzf#install()" }
    } }

    -- Treesitter + tcomment の組み合わせで vue ファイルでのコメントアウトがうまく動くまで必要
    -- use 'posva/vim-vue'
end)
