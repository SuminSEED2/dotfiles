vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local on_attach_lsp_server = function(server_name)
    local keymap = vim.keymap.set
    local builtin = require('telescope.builtin') 
    
    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filters such as only jumping to an error
    keymap("n", "[E", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    keymap("n", "]E", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)
    
    -- Toggle outline
    keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")
    
    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
    
    -- Call hierarchy
    keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")
    
    -- Floating terminal
    keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

    -- map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- map("n", "gd",  vim.lsp.buf.definition)
    -- map("n", "gD",  vim.lsp.buf.definition)
    -- map("n", "K",  vim.lsp.buf.hover)
    -- map("n", "gi", vim.lsp.buf.implementation)
    -- map("n", "gr", vim.lsp.buf.references)
    -- map("n", "gds", vim.lsp.buf.document_symbol)
    -- map("n", "gws", vim.lsp.buf.workspace_symbol)
    -- map("n", "<leader>cl", vim.lsp.codelens.run)
    -- map("n", "<leader>sh", vim.lsp.buf.signature_help)
    -- map("n", "<leader>rn", vim.lsp.buf.rename)
    -- map("n", "<leader>ca", vim.lsp.buf.code_action)
    -- map("n", "<leader>ws", function()
    --     require("metals").hover_worksheet()
    -- end)
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        -- "eslint",
        "jdtls",
        "rust_analyzer",
        "tsserver",
        "volar",
        "bashls"
    },
    -- automatic_installation = true
})
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {
            capabilities = require'cmp_nvim_lsp'.default_capabilities(),
            on_attach = function() on_attach_lsp_server(server_name) end
        }
    end
}
local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings.showImplicitArguments = true
metals_config.settings.excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" }
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt" },
    -- pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

local cmp = require("cmp")
cmp.setup({
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require('lspkind').cmp_format()
        -- format = require('lspkind').cmp_format({
        --     mode = "symbol_text",
        --     menu = ({
        --         buffer = "[Buffer]",
        --         nvim_lsp = "[LSP]",
        --         luasnip = "[LuaSnip]",
        --         nvim_lua = "[Lua]",
        --         latex_symbols = "[Latex]",
        --     })
        -- })
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
        { name = "nvim_lua" },
    }, {
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
