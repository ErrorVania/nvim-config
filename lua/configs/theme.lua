local M = {}

local telescopeBorderless = function(flavor)
	local cp = require("catppuccin.palettes").get_palette(flavor)

	return {
		TelescopeBorder = { fg = cp.surface0, bg = cp.surface0 },
		TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.surface1 },
		TelescopeMatching = { fg = cp.peach },
		TelescopeNormal = { bg = cp.surface0 },
		TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
		TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },
		TelescopeTitle = { fg = cp.crust, bg = cp.green },
		TelescopePreviewTitle = { fg = cp.crust, bg = cp.red },
		TelescopePromptTitle = { fg = cp.crust, bg = cp.mauve },
		TelescopePromptNormal = { fg = cp.flamingo, bg = cp.crust },
		TelescopePromptBorder = { fg = cp.crust, bg = cp.crust },
	}
end

local function startswith(a, b)
	return string.sub(a, 1, string.len(b)) == b
end

function M.set_theme(theme)
	if startswith(theme, 'catppuccin') then
		require("catppuccin").setup {
			highlight_overrides = {
				latte = telescopeBorderless('latte'),
				frappe = telescopeBorderless('frappe'),
				macchiato = telescopeBorderless('macchiato'),
				mocha = telescopeBorderless('mocha'),
			},
		}
	end
	vim.cmd('colorscheme ' .. theme)
end

return M
