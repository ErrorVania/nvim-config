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

local function _edit_config_files()
	local tele_ok, builtin = pcall(require, 'telescope.builtin')
	if tele_ok then
		builtin.find_files {
			cwd = vim.loop.fs_realpath(vim.fn.stdpath('config')),
			follow = true
		}
	end
end

import('which-key', function(wk)
	wk.setup {
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
			},
			u = { '<cmd>UndotreeToggle<cr>', "UndoTree" },
			N = {
				name = 'Neovim',
				c = { _edit_config_files, 'Edit all config files' },
				L = { '<cmd>Lazy<cr>', 'Lazy' },
				m = { '<cmd>Mason<cr>', 'Mason' }
			},
			e = { function() import('nvim-tree.api', function(n) n.tree.toggle {} end) end, 'Open NvimTree' },
			c = { '<cmd>Bdelete<cr>', 'Close Buffer' }
		},
		{ prefix = "<leader>" }
	)
end)
