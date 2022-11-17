local M = {}


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
