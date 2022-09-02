-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true }

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', options)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>', options)
map('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<leader>gg', '<cmd>LazyGit<cr>', options)
map('n', '<C-t>', '<cmd>lua require"floaterm".open({command="powershell"})<cr>', options)
map('n', '<C-s>', '<cmd>w<cr>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>c', '<cmd>bd<cr>', options)
