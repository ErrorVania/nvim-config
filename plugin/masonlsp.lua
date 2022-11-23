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

	local MasonColor = {
		MasonHeader = {bg = colors.green, fg = colors.mantle }
	}

	for hl, col in pairs(MasonColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end
