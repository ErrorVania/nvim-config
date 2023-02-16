import('lualine', function(lualine)

	local function getlsps()
		local names = {}
		local clients = vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() }

		for _, lsp in ipairs(clients) do
			table.insert(names, lsp.name)
		end

		if #names == 0 then
			return "No LSP"
		end

		return '[' .. table.concat(names, ", ") .. ']'
	end

	local function mode()
		return ""
	end

	lualine.setup {
		options = {
			disabled_filetypes = {
				'alpha', 'help'
			},
			globalstatus = true,
			section_separators = { left = '', right = '' },
			component_separators = { left = '|', right = '|' },
			-- theme = 'nord'
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { 'branch' },
			lualine_c = {
				{
					'diff',
					symbols = {
						added = '+',
						modified = '~',
						removed = '-'
					}
				}
			},
			lualine_x = { 'diagnostics', getlsps, 'filetype' },
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
end)
