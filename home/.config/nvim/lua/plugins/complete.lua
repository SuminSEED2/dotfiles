return {
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/vim-vsnip',
            'hrsh7th/cmp-vsnip',
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "path" },
                    { name = "nvim_lua" },
                }, {
                    { name = 'buffer' },
                }),
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- preselect = cmp.PreselectMode.Item,
                preselect = cmp.PreselectMode.None,
                mapping = cmp.mapping.preset.insert({
                    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-u>'] = function(fallback)
                        local entry = cmp.get_active_entry()
                        if (entry) then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end,
                    ["<Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ["<S-Tab>"] = function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                }),
            })
        end
    },
}
