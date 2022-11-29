local M = {}

function M.mason_config()
	local ok, mason = pcall(require, 'mason')
	if not ok then
		return
	end

	mason.setup {
		ui = {
			border = 'none'
		}
	}

	local colorok, colors = pcall(require, 'catppuccin.palettes')
	if colorok then
		colors = colors.get_palette()

		local MasonColor = {
			MasonHeader = { bg = colors.green, fg = colors.mantle }
		}

		for hl, col in pairs(MasonColor) do
			vim.api.nvim_set_hl(0, hl, col)
		end
	end
end

function M.masonlsp_config()
	local ok, masonlsp = pcall(require, 'mason-lspconfig')
	if not ok then
		return
	end

	masonlsp.setup()
end

function M.setup(use)
	use {
		'williamboman/mason.nvim',
		config = M.mason_config
	}

	use {
		'neovim/nvim-lspconfig'
	}

	use {
		'williamboman/mason-lspconfig.nvim',
		config = M.masonlsp_config
	}
end

return M
