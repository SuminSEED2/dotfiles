return {
    'neovim/nvim-lspconfig',
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            'neovim/nvim-lspconfig',
        },
        opts = {
            ensure_installed = {
                "clangd",
                "jdtls",
                "rust_analyzer",
                "tsserver",
                "volar",
                "bashls"
            },
            automatic_installation = true,
            on_attach = function(server_name) end
        },
        config = function(_, opts)
            require("mason-lspconfig").setup({
                ensure_installed = opts.ensure_installed,
                automatic_installation = opts.automatic_installation
            })
            require("mason-lspconfig").setup_handlers {
                function (server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = require'cmp_nvim_lsp'.default_capabilities(),
                        on_attach = function(server_name) opts.on_attach(server_name) end
                    }
                end
            }
        end
    },
    {
        'williamboman/mason.nvim',
        opts = {},
        config = function(_, opts)
            require("mason").setup(opts)
        end
    },
    {
        "glepnir/lspsaga.nvim",
        commit = "8159ef7af70f730652d7b24637fac9645803eded",
        event = "LspAttach",
        opts = {
                rename = {
                    in_select = false
                }
        },
        config = function(_, opts)
            require("lspsaga").setup(opts)
        end,
        dependencies = {
            {"nvim-tree/nvim-web-devicons"},
            {"nvim-treesitter/nvim-treesitter"}
        }
    },
    {
        "onsails/lspkind.nvim",
        opts = {},
        config = function(_, opts)
            require("lspkind").init(opts)
        end
    },
}
