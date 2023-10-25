-- vim.opt.equalalways = true -- windowのサイズの自動調整
vim.opt.scrollbind = false -- 分割ウィンドウのスクロール同期無効
vim.opt.splitbelow = true -- 分割方向、下
vim.opt.splitright = true -- 分割方向、右
vim.opt.number = true -- 行数表示
vim.opt.cursorline = true -- カーソル行をハイライト
vim.opt.signcolumn = "number"
vim.cmd("hi clear CursorLine")
-- vim.cmd("hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE")
-- vim.cmd("set fillchars+=vert:\▏")
