-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true }

map('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<C-t>', '<cmd>ToggleTerm<cr>', options)
map('n', '<C-s>', '<cmd>w<cr>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>x', '<cmd>bd<cr>', options)

map('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', options)
map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>', options)
map('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<cr>', options)


map('n', '<C-h>', '<C-W>h', options)
map('n', '<C-j>', '<C-W>j', options)
map('n', '<C-k>', '<C-W>k', options)
map('n', '<C-l>', '<C-W>l', options)


require('which-key').register(
	{
		f = {
			name = "File",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			g = { "<cmd>Telescope git_files<cr>", "Git Files" },
			h = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
		},
		c = {
			name = "Build/Run",
			b = { '<cmd>TermExec cmd="cmake --build build/" direction=tab<cr>', "Run cmake build in 'build/'"}
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
		}
	},
	{ prefix = "<leader>" }
)
