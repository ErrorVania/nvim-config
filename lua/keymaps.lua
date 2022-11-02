-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local nmap = function(mode, keys, command)
    return map(mode, keys, command, { noremap = true })
end

nmap('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
nmap('n', '<C-t>', '<cmd>ToggleTerm<cr>')
nmap('n', '<C-s>', '<cmd>w<cr>')
nmap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
nmap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')
nmap('n', '<leader>c', '<cmd>bd<cr>')

nmap('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>')
nmap('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
nmap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>')


nmap('n', '<C-h>', '<C-W>h')
nmap('n', '<C-j>', '<C-W>j')
nmap('n', '<C-k>', '<C-W>k')
nmap('n', '<C-l>', '<C-W>l')

function _lazygit_toggle()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = 'float'
    })
    lazygit:toggle()
end

function _edit_config_files()
	local files = {
		'/init.lua',
		'/lua/plugins.lua',
		'/lua/lspconfigs.lua',
		'/lua/vim-opts.lua',
		'/lua/keymaps.lua'
	}
	for i, f in ipairs(files) do
		local p = vim.fn.stdpath('config') .. f
		vim.cmd('edit ' .. p)
 	end
end


require('which-key').register(
	{
		f = {
			name = "File",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			g = { "<cmd>Telescope git_files<cr>", "Git Files" },
			h = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
		},
		l = {
			name = "LSP",
			d = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to Declaration' },
			D = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to Definition' },
			r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Go to References' },
			R = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' }
		},
		g = {
			name = "Git",
			g = { '<cmd>lua _lazygit_toggle()<CR>', 'LazyGit' },
		},
		N = {
			name = 'Neovim',
			c = {'<cmd>lua _edit_config_files()<CR>', 'Edit all config files'}
		}
	},
	{ prefix = "<leader>" }
)


