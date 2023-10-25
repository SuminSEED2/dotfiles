return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
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
                        ["<C-u>"] = false,
                        ["<C-j>"] = actions.preview_scrolling_down,
                        ["<C-k>"] = actions.preview_scrolling_up
                    },
                    n = {
                        ["<C-c>"] = actions.close
                    }
                }
            }
        })
    end
}
