local ok, whichkey = pcall(require, 'which-key')
if not ok then
	return
end

whichkey.setup{
	window = {
		border = 'single'
	}
}

local function _lazygit_toggle()
	local tterm_ok, term = pcall(require, 'toggleterm.terminal')
	if tterm_ok then
    	local Terminal = term.Terminal
    	local lazygit = Terminal:new({
        	cmd = "lazygit",
        	hidden = true,
        	direction = 'float'
    	})
    	lazygit:toggle()
	end
end

local function _edit_config_files()
	local tele_ok, builtin = pcall(require, 'telescope.builtin')
	if tele_ok then
 		builtin.find_files{
 			cwd = vim.loop.fs_realpath(vim.fn.stdpath('config')),
 			follow = true
 		}
	end
end


whichkey.register(
	{
		f = {
			name = "Find",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			g = { "<cmd>Telescope git_files<cr>", "Git Files" },
			h = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
			p = { "<cmd>Telescope project<cr>", "Projects"},
			b = { "<cmd>Telescope file_browser<cr>", "File Browser"},
			c = { "<cmd>Telescope colorscheme<cr>", "Colorschemes"}
		},
		l = {
			name = "LSP",
			d = { vim.lsp.buf.declaration, 'Go to Declaration' },
			D = { vim.lsp.buf.definition, 'Go to Definition' },
			r = { vim.lsp.buf.references, 'Go to References' },
			R = { vim.lsp.buf.rename, 'Rename' },
			f = { vim.lsp.buf.format, 'Format'}
		},
		g = {
			name = "Git",
			g = { _lazygit_toggle, 'LazyGit' },
		},
		u = {'<cmd>UndotreeToggle<cr>', "UndoTree"},
		N = {
			name = 'Neovim',
			c = { _edit_config_files, 'Edit all config files'},
			p = {
				name = 'Packer',
				c = {'<cmd>PackerCompile<cr>', 'Compile'},
				s = {'<cmd>PackerSync<cr>', 'Sync'},
				i = {'<cmd>PackerInstall<cr>', 'Install'},
				u = {'<cmd>PackerUpdate<cr>', 'Update'},
			},
			m = {'<cmd>Mason<cr>', 'Mason'}
		}
	},
	{ prefix = "<leader>" }
)
