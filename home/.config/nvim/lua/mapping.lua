local keyOpts = { noremap = true }
local keymap = vim.keymap.set
local telescope_builtin = require('telescope.builtin') 

local lsp_attach_callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    keymap("n", "<leader>q", function ()
        vim.lsp.buf.format({
            -- bufnr = bufnr,
            timeout_ms = 5000,
            filter = function(client)
                return client.name == "null-ls"
            end
        })
    end, keyOpts)

    local key = "gh"
    keymap("n", key, "<cmd>Lspsaga lsp_finder<CR>", keyOpts)
    -- keymap("n", key, telescope_builtin.lsp_implementations, keyOpts)
    -- keymap("n", key, telescope_builtin.lsp_references, keyOpts)

    local key = "<Leader>sb"
    -- keymap("n", key, "<cmd>Lspsaga show_buf_diagnostics<CR>", keyOpts)
    keymap('n', key, telescope_builtin.diagnostics, keyOpts)
    keymap("n", "<Leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", keyOpts)
    keymap("n", "<Leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", keyOpts)
    keymap("n", "<Leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", keyOpts)

    keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
    keymap("n", "gD", "<cmd>Lspsaga goto_definition<CR>")
    keymap("n", "gp", "<cmd>Lspsaga peek_type_definition<CR>")
    keymap("n", "gP", "<cmd>Lspsaga goto_type_definition<CR>")

    local key = 'K'
    -- keymap("n", key, "<cmd>Lspsaga hover_doc<CR>")
    keymap("n", key, "<cmd>Lspsaga hover_doc ++keep<CR>")
    -- keymap("n", key, vim.lsp.buf.hover)

    local key = "<Leader>ca"
    keymap({ "n", "v" }, key, "<cmd>Lspsaga code_action<CR>")

    local key = "<Leader>rn"
    -- keymap("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")
    keymap("n", "<Leader>rn", "<cmd>Lspsaga rename ++project<CR>")

    local key = "<C-p>"
    keymap("n", key, "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    local key = "<C-n>"
    keymap("n", key, "<cmd>Lspsaga diagnostic_jump_next<CR>")

    keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")

    keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

    keymap("n", "gds", vim.lsp.buf.document_symbol)
    keymap("n", "gws", vim.lsp.buf.workspace_symbol)

    keymap("n", "<leader>dc", function()
      require("dap").continue()
    end)
    
    keymap("n", "<leader>dr", function()
      require("dap").repl.toggle()
    end)
    
    keymap("n", "<leader>dK", function()
      require("dap.ui.widgets").hover()
    end)

    keymap("n", "<leader>dt", function()
        require("dap").toggle_breakpoint()
    end)

    keymap("n", "<leader>dso", function()
        require("dap").step_over()
    end)

    keymap("n", "<leader>dsi", function()
        require("dap").step_into()
    end)

    keymap("n", "<leader>dl", function()
        require("dap").run_last()
    end)
end
local lsp_attach_group = vim.api.nvim_create_augroup('mapping.lsp-attach', { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_attach_group,
    callback = lsp_attach_callback
})

keymap("n", "<Leader>fs", telescope_builtin.lsp_dynamic_workspace_symbols)
keymap('n', '<Leader>ff', telescope_builtin.find_files)
keymap('n', '<Leader>fg', telescope_builtin.live_grep)
keymap('n', '<Leader>fb', telescope_builtin.buffers)
keymap('n', '<Leader>fh', telescope_builtin.help_tags)


vim.keymap.set("n", "<Leader><CR>", ":source $MYVIMRC<CR>", keyOpts)

-- translate 翻訳ツール
vim.keymap.set("v", "<Leader>t", "<cmd>let g:translate_source = 'en'<CR> | <cmd>let g:translate_target = 'ja'<CR> | <Plug>(VTranslate)", keyOpts)
vim.keymap.set("v", "<Leader>T", "<cmd>let g:translate_source = 'ja'<CR> | <cmd>let g:translate_target = 'en'<CR> | <Plug>(VTranslate)", keyOpts)

-- QuickRun
vim.keymap.set("n", "<F5>", ":QuickRun -mode n<CR>", keyOpts)
vim.keymap.set("v", "<F5>", ":QuickRun -mode v<CR>", keyOpts)
-- vim.keymap.set("n", "<Leader>q", ":QuickRun -mode n<CR>", keyOpts)
-- vim.keymap.set("v", "<Leader>q", ":QuickRun -mode v<CR>", keyOpts)

-- Clipboard
vim.keymap.set("", "<Leader>y", '"*y', keyOpts)
vim.keymap.set("", "<Leader>Y", '"*Y', keyOpts)
vim.keymap.set("", "<Leader>p", '"*p', keyOpts)
vim.keymap.set("", "<Leader>P", '"*P', keyOpts)
vim.keymap.set("", "<Leader>d", '"*d', keyOpts)
vim.keymap.set("", "<Leader>D", '"*D', keyOpts)

-- " Tagbar
-- nnoremap <F8> :TagbarToggle<CR>
--
-- " NERDTree
-- nnoremap <F2> :NERDTreeToggle<CR>
-- nnoremap <Leader>f :NERDTreeToggle<CR>
-- vim.keymap.set("n", "<Leader>f", ":NERDTreeToggle<CR>", keyOpts)
vim.keymap.set("n", "<F2>", ":NERDTreeToggle<CR>", keyOpts)

-- " EasyAlign
-- vmap <Enter> <Plug>(EasyAlign)
--
-- " terminal
-- tnoremap <silent> <ESC> <C-\><C-n>
--

-- "rest-client
-- vmap <Leader>r :CocCommand rest-client.request <cr>
--
-- noremap <Leader>y "*y
-- noremap <Leader>Y "*Y
-- noremap <Leader>p "*p
-- noremap <Leader>P "*P
-- noremap <Leader>d "*d
-- noremap <Leader>D "*D
--
-- nnoremap j gj
-- nnoremap gj j
-- nnoremap k gk
-- nnoremap gk k
-- nnoremap ^ g^
-- nnoremap g^ ^
-- nnoremap 0 g0
-- nnoremap g0 0
-- " nnoremap $ g$
-- nnoremap g$ $
