package.path = package.path .. "~\\AppData\\Local\\nvim"
require('plugins')
require('vim-opts')

require("bufferline").setup{}
require("gitsigns").setup()
require("nvim-tree").setup()
require("Comment").setup()

require("nvim-lsp-installer").setup{}
require("lspconfig").sumneko_lua.setup{}

require("nvim-treesitter.configs").setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}




-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true }

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', options)
map('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<leader>gg', '<cmd>LazyGit<cr>', options)
map('n', '<C-t>', '<cmd>lua require"floaterm".open({command="powershell"})<cr>', options)
map('n', '<C-s>', '<cmd>w<cr>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>c', '<cmd>bd<cr>', options)
