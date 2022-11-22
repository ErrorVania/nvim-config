local M = {}

function M.getlsps()
	local names = {}
	local clients = vim.lsp.get_active_clients{bufnr = vim.api.nvim_get_current_buf()}

	for i, lsp in ipairs(clients) do
		table.insert(names, lsp.name)
	end
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
			lualine_x = { 'diagnostics', "require'configs.statusline'.getlsps()", 'filetype' },
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
