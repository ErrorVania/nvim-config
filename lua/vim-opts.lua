vim.opt.timeoutlen = 0
vim.wo.number = true
vim.g.encoding = 'UTF-8'
vim.opt.termguicolors = true
vim.o.cursorline = true
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.opt.mouse = 'a'
vim.cmd("filetype plugin indent on")
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.pumheight = 10
vim.opt.fillchars = 'eob: '
vim.cmd("set completeopt=menu,menuone,noselect")

require('configs.theme').load_theme()
