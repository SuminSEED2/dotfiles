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
                return utils.root_has_file({ "node_modules/.bin/prettier" })
            end
        }),
    },
    on_attach = function(client, bufnr)
        vim.keymap.set("n", "<leader>q", function ()
            vim.lsp.buf.format({
                -- bufnr = bufnr,
                timeout_ms = 5000,
                filter = function(client)
                    return client.name == "null-ls"
                end
            })
        end)
    end,
    debug = false,
})
