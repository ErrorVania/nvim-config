-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true }

map('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<leader>gg', '<cmd>LazyGit<cr>', options)
map('n', '<C-t>', '<cmd>TermExec cmd="pwsh & exit"<cr>', options)
map('n', '<C-s>', '<cmd>w<cr>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>c', '<cmd>bd<cr>', options)

map('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', options)
map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>', options)


map('n', '<leader>Lc', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\init.lua<cr>', options)
map('n', '<leader>Ll', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\lspconfigs.lua<cr>', options)
map('n', '<leader>Lk', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\keymaps.lua<cr>', options)
map('n', '<leader>Lo', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\vim-opts.lua<cr>', options)
map('n', '<leader>Lp', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\plugins.lua<cr>', options)
