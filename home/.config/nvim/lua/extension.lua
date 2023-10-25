vim.g.filetype_m = 'objc'

local extension_group = vim.api.nvim_create_augroup('config_extension', { clear = true })

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.ejs' },
    callback = function()
        vim.cmd("setfiletype html")
    end,
    group = extension_group,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.tmux.conf' },
    callback = function()
        vim.cmd("setfiletype tmux")
    end,
    group = extension_group,
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { '*.tsx' },
    callback = function()
        vim.cmd("setfiletype tsx")
    end,
    group = extension_group,
})
