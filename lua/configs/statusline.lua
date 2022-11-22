local M = {}

function M.getlsps()
	local names = {}
	for _, lsp in vim.lsp.get_active_clients({bufnr = vim.api.nvim_get_current_buf()}) do
		names[#names+1] = lsp.name
	end
	print(names[1])
	return table.concat(names, ", ")
end

function M.lualine_setup()
	local ok, lualine = pcall(require, 'lualine')
	if not ok then
		return
	end

	lualine.setup {
		options = {
			disabled_filetypes = {
				'alpha'
			},
			globalstatus = true
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch' },
			lualine_c = {
				{
					'diff',
					symbols = {
						added = ' ',
						modified = 'ﰣ ',
						removed = 'ﯰ '
					}
				}
			},
			-- TODO fix!
			lualine_x = { "vim.inspect(require'configs.statusline'.getlsps())",'diagnostics', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {}
		}
	}
end

function M.setup(use)
	use {
		'nvim-lualine/lualine.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
		config = M.lualine_setup
	}
end

return M
