local function _lazygit_toggle()
	local tterm_ok, term = pcall(require, 'toggleterm.terminal')
	if tterm_ok then
		local Terminal = term.Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = 'float',
			close_on_exit = true,
			on_open = function(t)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(t.bufnr, "t", "<esc>", "<esc>", { noremap = true, silent = true })
			end,
			on_close = function(t)
				vim.cmd("bufdo e!") -- reload all buffers to reflect git changes
			end
		})
		lazygit:toggle()
	end
end

return {
	'folke/which-key.nvim',
	event = 'VeryLazy',
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = function()
		local wk = require('which-key')
		wk.setup {
			window = {
				border = 'none'
			}
		}

		local nvimtree = require('nvim-tree.api')
		local tele = require('telescope.builtin')
		local bufdel = require('bufdelete')

		wk.register(
			{
				f = {
					name = "Find",
					f = { tele.find_files, "Find File" },
					g = { tele.git_files, "Git Files" },
					h = { tele.oldfiles, "Recent Files" },
					p = { "<cmd>Telescope project<cr>", "Projects" },
					b = { tele.buffers, "Buffers" },
					B = { "<cmd>Telescope file_browser<cr>", "File Browser" },
					c = { require 'configs.themepicker'.run, "Colorschemes" }
				},
				l = {
					name = "LSP",
					d = { vim.lsp.buf.declaration, 'Go to Declaration' },
					D = { vim.lsp.buf.definition, 'Go to Definition' },
					r = { vim.lsp.buf.references, 'Go to References' },
					R = { vim.lsp.buf.rename, 'Rename' },
					f = { vim.lsp.buf.format, 'Format' },
					a = { vim.lsp.buf.code_action, 'Code Action' }
				},
				g = {
					name = "Git",
					g = { _lazygit_toggle, 'LazyGit' },
					f = { tele.git_files, "Git Files" },
					b = { tele.git_branches, 'Git Branches' },
					s = { tele.git_status, 'Git Status' }
				},
				u = { '<cmd>UndotreeToggle<cr>', "UndoTree" },
				N = {
					name = 'Neovim',
					L = { '<cmd>Lazy<cr>', 'Lazy' },
					m = { '<cmd>Mason<cr>', 'Mason' }
				},
				e = { nvimtree.tree.toggle, 'Open NvimTree' },
				c = { function() bufdel.bufdelete(0, true) end, 'Close Buffer' }
			},
			{ prefix = "<leader>" }
		)
	end
}
