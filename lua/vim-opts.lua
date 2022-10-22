vim.opt.timeoutlen = 0
vim.cmd('colorscheme tokyonight')
vim.wo.number = true
vim.g.encoding = 'UTF-8'
vim.opt.termguicolors = true
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.opt.mouse = 'a'
vim.cmd("filetype plugin indent on")
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.g.floaterm_shell = 'powershell'

vim.cmd("set completeopt=menu,menuone,noselect")
vim.cmd("set noet ci pi sts=0 sw=4 ts=4")

vim.opt.foldmethod="expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
