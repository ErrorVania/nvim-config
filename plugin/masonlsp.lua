local mason_ok, mason = pcall(require, 'mason')
local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not masonlsp_ok then
	return
end

mason.setup{
	ui = {
		border = 'none'
	}
}
masonlsp.setup()

local colorok, colors = pcall(require, 'catppuccin.palettes')
if colorok then
	colors = colors.get_palette()

	local TelescopeColor = {
		-- TelescopeMatching = { fg = colors.flamingo },
		-- TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
		-- TelescopePromptPrefix = { bg = colors.surface0 },
		-- TelescopePromptNormal = { bg = colors.surface0 },
		-- TelescopeResultsNormal = { bg = colors.mantle },
		-- TelescopePreviewNormal = { bg = colors.mantle },
		-- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
		-- TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
		-- TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
		-- TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
		-- TelescopeResultsTitle = { fg = colors.mantle },
		-- TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
		MasonHeader = {bg = colors.green, fg = colors.mantle }
	}

	for hl, col in pairs(TelescopeColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end
