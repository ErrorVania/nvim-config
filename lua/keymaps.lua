-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local nmap = function(mode, keys, command)
	return map(mode, keys, command, { noremap = true })
end

nmap('n', '<C-s>', '<cmd>w<cr>')
nmap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
nmap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
nmap('n', '<C-o>', '<cmd>OverseerToggle<cr>')
nmap('n', '<leader>c', '<cmd>Bdelete<cr>')

nmap('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>')
nmap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
nmap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>')


nmap('n', '<C-h>', '<C-W>h')
nmap('n', '<C-j>', '<C-W>j')
nmap('n', '<C-k>', '<C-W>k')
nmap('n', '<C-l>', '<C-W>l')
