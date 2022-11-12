local ok, whichkey = pcall(require, 'which-key')
if not ok then
	return
end

whichkey.setup{
	window = {
		border = 'single'
	}
}

function _lazygit_toggle()
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

function _edit_config_files()
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
