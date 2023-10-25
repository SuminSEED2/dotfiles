return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = function(_, opts)
        local null_ls = require "null-ls"
        null_ls.setup({
            sources = {
                null_ls.builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ "node_modules/.bin/eslint" })
                    end
                }),
                null_ls.builtins.formatting.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ "node_modules/.bin/eslint" })
                    end
                }),
                null_ls.builtins.formatting.prettierd.with({
                    condition = function(utils)
                        return utils.root_has_file({ "node_modules/.bin/prettier" }) and utils.root_has_file({ ".prettierrc", ".prettierrc.json" })
                    end
                }),
            },
            debug = false,
        })
    end
}
