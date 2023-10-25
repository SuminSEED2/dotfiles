vim.opt.expandtab = true -- tab入力をスペースにする
vim.opt.tabstop = 4 -- tab文字の表現
vim.opt.softtabstop = 4 -- 連続したスペースの扱い
vim.opt.smarttab = true
vim.opt.shiftwidth = 4 -- 自動インデント数

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true

local indent_group = vim.api.nvim_create_augroup('config_indent', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'yaml' },
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
  end,
  group = indent_group
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'make' },
  callback = function()
    vim.opt.expandtab = false
  end,
  group = indent_group
})
