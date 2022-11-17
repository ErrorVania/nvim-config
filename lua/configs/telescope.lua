local M = {}

function M.telescope_setup()
	local telescope_ok, telescope = pcall(require, 'telescope')
	if not telescope_ok then
		return
	end

	telescope.setup{
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown{}
			}
		}
	}
end

function M.projects_setup()
	local telescope_ok, telescope = pcall(require, 'telescope')
	local projects_ok, projects = pcall(require, 'project_nvim')

	if not projects_ok or not telescope_ok then
		return
	end

	projects.setup{
		patterns = {'.git', 'Makefile', 'CMakeLists.txt'},
    	show_hidden = false
	}

	telescope.load_extension('projects')
end

function M.file_browser_setup()
	local telescope_ok, telescope = pcall(require, 'telescope')
	telescope.load_extension('file_browser')
end

function M.uiselect_setup()
	local telescope_ok, telescope = pcall(require, 'telescope')
	telescope.load_extension('ui-select')
end

function M.setup(use)
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = {
			'nvim-lua/plenary.nvim',
		},
		config = M.telescope_setup
	}

	use {
		'nvim-telescope/telescope-file-browser.nvim',
		requires = 'nvim-telescope/telescope.nvim',
		after = 'telescope.nvim',
		config = M.file_browser_setup
	}

	use {
		'ahmedkhalf/project.nvim',
		requires = 'nvim-telescope/telescope.nvim',
		after = 'telescope.nvim',
		config = M.projects_setup
	}

	use {
		'nvim-telescope/telescope-ui-select.nvim',
		requires = 'nvim-telescope/telescope.nvim',
		after = 'telescope.nvim',
		config = M.uiselect_setup
	}
end

local colorok, colors = pcall(require, 'catppuccin.palettes')
if colorok then
	colors = colors.get_palette()

	local TelescopeColor = {
		TelescopeMatching = { fg = colors.flamingo },
		TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
		TelescopePromptPrefix = { bg = colors.surface0 },
		TelescopePromptNormal = { bg = colors.surface0 },
		TelescopeResultsNormal = { bg = colors.mantle },
		TelescopePreviewNormal = { bg = colors.mantle },
		TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
		TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
		TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
		TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
		TelescopeResultsTitle = { fg = colors.mantle },
		TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
	}

	for hl, col in pairs(TelescopeColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end

return M
