vim.cmd([[let g:python3_host_prog = $PYENV_ROOT.'/versions/neovim/bin/python']])
vim.cmd([[let g:python_host_prog = $PYENV_ROOT.'/versions/neovim2/bin/python']])

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.g.mapleader = " " -- キーマップリーダー

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("plugins")

-- local status = pcall(require, "plugins")
-- if (not status) then return end
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     pattern = { "plugins.lua" },
--     command = "PackerCompile"
-- })
--
-- -- require'nvim-treesitter.configs'.setup {
-- --     -- enable = true,
-- --     -- additional_vim_regex_highlighting = false
-- --     ensure_installed = 'all',
-- --     highlight = {
-- --         enable = true,
-- --
-- --         -- Treesitter + tcomment の組み合わせで vue ファイルでのコメントアウトがうまく動くまで必要
-- --         -- disable = { "vue" }
-- --     },
-- -- }
--

require('basic')
require('backup')
require('indent')
require('color')
require('editor')
require('backup')
require('diff')
require('buffer')
require('statusline')
require('search')
require('window')
require('mapping')
require('extension')
