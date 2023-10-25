-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built-in
-- LSP. Be sure to thoroughly read the `:help nvim-metals` docs to get an
-- idea of what everything does. Again, these are meant to serve as an example,
-- if you just copy pasta them, then should work,  but hopefully after time
-- goes on you'll cater them to your own liking especially since some of the stuff
-- in here is just an example, not what you probably want your setup to be.
--
-- Unfamiliar with Lua and Neovim?
--  - Check out https://github.com/nanotee/nvim-lua-guide
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore is a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-cmp
--   - hrsh7th/cmp-nvim-lsp for lsp completion sources
--   - hrsh7th/cmp-vsnip for snippet sources
--   - hrsh7th/vim-vsnip for snippet sources
--
-- - https://github.com/wbthomason/packer.nvim for package management
-- - https://github.com/mfussenegger/nvim-dap (for debugging)
-------------------------------------------------------------------------------
local api = vim.api
local cmd = vim.cmd
local map = vim.keymap.set
map("n", "<leader>q", function () vim.lsp.buf.format({
    timeout_ms = 5000,
}) end)


----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

local default_capabilities = require'cmp_nvim_lsp'.default_capabilities()

local server_names = ''
    local key = 'gray'
    local str = ''
    map("n", "<leader>y", function() str = str .. 'hello' end)
    map("n", "<leader>y", function() str = str .. 'hello' end)
    map("n", "<leader>k", function() print(str) end)
    -- map("n", "<leader>y", function() print'hello' end)
    -- map("n", "<leader>y", function() print'hello' end)
local on_attach = function(server_name)
    server_names = server_names .. server_name
    -- print(server_names)
    local map = vim.keymap.set
    -- LSP mappings
    -- map("n", "<leader>Y", function() vim.cmd[[echo 'helloooo']]; vim.cmd[[echo 'helloooo']] end)
    -- map("n", "<leader>Y", function() vim.cmd[[echo 'helleeee']] end)
    map("n", "gd",  vim.lsp.buf.definition)
    map("n", "gD",  vim.lsp.buf.definition)
    map("n", "K",  vim.lsp.buf.hover)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "gds", vim.lsp.buf.document_symbol)
    map("n", "gws", vim.lsp.buf.workspace_symbol)
    map("n", "<leader>cl", vim.lsp.codelens.run)
    map("n", "<leader>sh", vim.lsp.buf.signature_help)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    -- map("n", "<leader>q", function () vim.lsp.buf.format({
    --     timeout_ms = 5000,
    --     filter = function(client)
    --         return client.name == "null-ls"
    --     end
    -- }) end)
    map("n", "<leader>q", function () vim.lsp.buf.format() end)
    map("n", "<leader>ca", vim.lsp.buf.code_action)
    map("n", "<leader>ws", function()
        require("metals").hover_worksheet()
    end)
    -- all workspace diagnostics
    map("n", "<leader>aa", vim.diagnostic.setqflist)
    -- all workspace errors
    map("n", "<leader>ae", function()
        vim.diagnostic.setqflist({ severity = "E" })
    end)
    -- all workspace warnings
    map("n", "<leader>aw", function()
        vim.diagnostic.setqflist({ severity = "W" })
    end)
    -- buffer diagnostics only
    map("n", "<leader>d", vim.diagnostic.setloclist)

    map("n", "[c", function()
        vim.diagnostic.goto_prev({ wrap = false })
    end)
    
    map("n", "]c", function()
        vim.diagnostic.goto_next({ wrap = false })
    end)

    -- Example mappings for usage with nvim-dap. If you don't use that, you can
    -- skip these
    map("n", "<leader>dc", function()
        require("dap").continue()
    end)
    map("n", "<leader>dr", function()
        require("dap").repl.toggle()
    end)
    map("n", "<leader>dK", function()
        require("dap.ui.widgets").hover()
    end)
    map("n", "<leader>dt", function()
        require("dap").toggle_breakpoint()
    end)
    map("n", "<leader>dso", function()
        require("dap").step_over()
    end)
    map("n", "<leader>dsi", function()
        require("dap").step_into()
    end)
    map("n", "<leader>dl", function()
        require("dap").run_last()
    end)
end

require("mason").setup()
-- require("mason-lspconfig").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        -- "clangd",
        -- "eslint",
        -- "jdtls",
        -- "rust_analyzer",
        "tsserver",
        -- "volar",
        -- "bashls"
    },
    -- automatic_installation = false
})
-- require("mason-lspconfig").setup_handlers {
--     function (server_name)
--         -- if server_name == "eslint" then  return end
--         require("lspconfig")[server_name].setup {
--             capabilities = default_capabilities,
--             on_attach = function()
--                 map("n", "gD",  vim.lsp.buf.definition)
--                 map("n", "K",  vim.lsp.buf.hover)
--                 map("n", "gi", vim.lsp.buf.implementation)
--                 map("n", "gr", vim.lsp.buf.references)
--                 map("n", "gds", vim.lsp.buf.document_symbol)
--                 map("n", "gws", vim.lsp.buf.workspace_symbol)
--                 map("n", "<leader>cl", vim.lsp.codelens.run)
--                 map("n", "<leader>sh", vim.lsp.buf.signature_help)
--                 map("n", "<leader>rn", vim.lsp.buf.rename)
--                 map("n", "<leader>q", vim.lsp.buf.format)
--                 map("n", "<leader>ca", vim.lsp.buf.code_action)
--                 map("n", "<leader>ws", function()
--                     require("metals").hover_worksheet()
--                 end)
--                 -- all workspace diagnostics
--                 map("n", "<leader>aa", vim.diagnostic.setqflist)
--                 -- all workspace errors
--                 map("n", "<leader>ae", function()
--                     vim.diagnostic.setqflist({ severity = "E" })
--                 end)
--                 -- all workspace warnings
--                 map("n", "<leader>aw", function()
--                     vim.diagnostic.setqflist({ severity = "W" })
--                 end)
--                 -- buffer diagnostics only
--                 map("n", "<leader>d", vim.diagnostic.setloclist)
--
--                 map("n", "[c", function()
--                     vim.diagnostic.goto_prev({ wrap = false })
--                 end)
--                 
--                 map("n", "]c", function()
--                     vim.diagnostic.goto_next({ wrap = false })
--                 end)
--
--                 -- Example mappings for usage with nvim-dap. If you don't use that, you can
--                 -- skip these
--                 map("n", "<leader>dc", function()
--                     require("dap").continue()
--                 end)
--                 map("n", "<leader>dr", function()
--                     require("dap").repl.toggle()
--                 end)
--                 map("n", "<leader>dK", function()
--                     require("dap.ui.widgets").hover()
--                 end)
--                 map("n", "<leader>dt", function()
--                     require("dap").toggle_breakpoint()
--                 end)
--                 map("n", "<leader>dso", function()
--                     require("dap").step_over()
--                 end)
--                 map("n", "<leader>dsi", function()
--                     require("dap").step_into()
--                 end)
--                 map("n", "<leader>dl", function()
--                     require("dap").run_last()
--                 end)
--             end
--         }
--     end
-- }
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {
            capabilities = default_capabilities,
            on_attach = function() on_attach(server_name) end
        }
    end
}

require('mason-core.package')

local cmp = require("cmp")
cmp.setup({
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
    }, {
        { name = 'buffer' }
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },
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

----------------------------------
-- LSP Setup ---------------------
----------------------------------
local metals_config = require("metals").bare_config()
-- metals_config.settings.showImplicitArguments = true
metals_config.init_options.statusBarProvider = "on"
metals_config.settings.showImplicitArguments = true
metals_config.settings.excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" }


-- *READ THIS*
-- I *highly* recommend setting statusBarProvider to true, however if you do,
-- you *have* to have a setting to display this in your statusline or else
-- you'll not see any messages from metals. There is more info in the help
-- docs about this
-- metals_config.init_options.statusBarProvider = "on"

-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Debug settings if you're using nvim-dap
local dap = require("dap")

dap.configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
            runType = "testTarget",
        },
    },
}

metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
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
