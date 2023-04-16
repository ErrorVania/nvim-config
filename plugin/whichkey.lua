local function _lazygit_toggle()
	local tterm_ok, term = pcall(require, 'toggleterm.terminal')
	if tterm_ok then
		local Terminal = term.Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = 'float',
			close_on_exit = true
		})
		lazygit:toggle()
	end
end

local function _edit_config_files()
	local tele_ok, builtin = pcall(require, 'telescope.builtin')
	if tele_ok then
		builtin.find_files {
			cwd = vim.loop.fs_realpath(vim.fn.stdpath('config')),
			follow = true
		}
	end
end

import({'which-key', 'nvim-tree.api'}, function(table)
	local wk = table['which-key']
	local nv = table['nvim-tree.api']

	wk.setup{
		window = {
			border = 'single'
		}
	}

	wk.register(
	{
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			g = { "<cmd>Telescope git_files<cr>", "Git Files" },
			h = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
			p = { "<cmd>Telescope project<cr>", "Projects" },
			b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
			c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes" }
		},
		l = {
			name = "LSP",
			d = { vim.lsp.buf.declaration, 'Go to Declaration' },
			D = { vim.lsp.buf.definition, 'Go to Definition' },
			r = { vim.lsp.buf.references, 'Go to References' },
			R = { vim.lsp.buf.rename, 'Rename' },
			f = { vim.lsp.buf.format, 'Format' },
			a = { vim.lsp.buf.code_action, 'Code Action'}
		},
		g = {
			name = "Git",
			g = { _lazygit_toggle, 'LazyGit' },
		},
		u = { '<cmd>UndotreeToggle<cr>', "UndoTree" },
		N = {
			name = 'Neovim',
			c = { _edit_config_files, 'Edit all config files' },
			p = {
				name = 'Packer',
				c = { '<cmd>PackerCompile<cr>', 'Compile' },
				s = { '<cmd>PackerSync<cr>', 'Sync' },
				i = { '<cmd>PackerInstall<cr>', 'Install' },
				u = { '<cmd>PackerUpdate<cr>', 'Update' },
			},
			m = { '<cmd>Mason<cr>', 'Mason' }
		},
		e = { nv.tree.toggle, 'Open NvimTree'},
		c = {'<cmd>Bdelete<cr>', 'Close Buffer'}
	},
	{ prefix = "<leader>" }
)
end)
