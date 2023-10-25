return {
    'thinca/vim-quickrun',
    lazy = true,
    cmd = 'QuickRun',
    dependencies = {
        'osyo-manga/shabadou.vim',
        {
            'Shougo/vimproc.vim',
            build = "make"
        }
    },
    opts = {
        ['outputter'] = 'multi',
        ['outputter/multi/targets'] = { 'buffer', 'error' },
        ['outputter/error/error'] = 'quickfix',
        ['outputter/error/success'] = 'null',
        ['outputter/buffer/opener'] = 'botright 13new',
        ['outputter/buffer/bufname'] = "[quickrun output]",
        ['outputter/buffer/into'] = 0,
        ['outputter/quickfix/open_cmd'] = 'copen 13',
        ['outputter/quickfix/into'] = 0,
        ['hook/time/enable'] = 1,
        ['runner'] = 'vimproc',
        ['runner/vimproc/updatetime'] = 300,
        ['hook/close_quickfix/enable_hook_loaded'] = 1,
        ['hook/close_quickfix/enable_success'] = 1,
        ['hook/close_buffer/enable_failure'] = 1,
    },
    config = function(_, opts) 
        local quickrun_config = vim.g.quickrun_config or {}
        quickrun_config._ = opts
        -- quickrun_config.typescript = { type = "typescript/tsc" }
        -- quickrun_config["typescript/tsc"] = {
        --     command = 'tsc',
        --     exec = { '%c --target esnext --module commonjs %o %s', 'node %s:r.js' },
        --     -- 'tempfile': '%{tempname()}.ts',
        --     -- 'hook/sweep/files': ['%S:p:r.js'],
        -- }
        vim.g.quickrun_config = quickrun_config

        local quickrun_group = vim.api.nvim_create_augroup('config_quickrun', { clear = true })
        local bufname = opts['outputter/buffer/bufname']

        -- vim.api.nvim_create_autocmd({ 'WinClosed' }, {
        -- pattern = { bufname },
        vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
            group = quickrun_group,
            pattern = { "*" .. bufname .. "*" },
            callback = function()
                vim.fn["quickrun#session#sweep"]()
            end
        })

        vim.api.nvim_create_autocmd({ 'VimLeave' }, {
            group = quickrun_group,
            callback = function()
                vim.fn["quickrun#session#sweep"]()
            end
        })

        vim.api.nvim_create_autocmd({ 'Filetype' }, {
            group = quickrun_group,
            pattern = { "quickrun" },
            command = [[nnoremap <buffer>q :bwipeout<CR>]]
        })

        vim.api.nvim_create_autocmd({ 'Filetype' }, {
            group = quickrun_group,
            pattern = { "quickrun" },
            command = [[nnoremap <buffer><expr> <C-c> quickrun#session#exists() ? quickrun#session#sweep() : ":bwipeout<CR>"]]
        })

        vim.api.nvim_create_autocmd({ 'Filetype' }, {
            group = quickrun_group,
            pattern = { "qf" },
            command = [[nnoremap <buffer>q :cclose<CR>]]
        })
    end
}
