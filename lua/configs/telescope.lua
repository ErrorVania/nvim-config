local M = {}


function M.telescope_setup()
	local ok, telescope = pcall(require, 'telescope')
	if not ok then
		return
	end


	telescope.setup {
		defaults = {
			prompt_prefix = ' '
		},
		extensions = {
			['ui-select'] = {
				require('telescope.themes').get_dropdown {}
			},
			project = {
				sync_with_nvim_tree = true,
				theme = 'dropdown'
			},
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = 'smart_case'
			}
		},
		pickers = {
			find_files = require('telescope.themes').get_dropdown {
				previewer = false
			},
			oldfiles = require('telescope.themes').get_dropdown {
				previewer = false
			},
			colorscheme = require('telescope.themes').get_dropdown {
				previewer = false,
				prompt_prefix = ' ',
				prompt_title = 'Themes'
			}
		}
	}


	telescope.load_extension('project')
	telescope.load_extension('file_browser')
	telescope.load_extension('ui-select')
	telescope.load_extension('fzf')
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
	}

	use {
		'nvim-telescope/telescope-project.nvim',
		requires = 'nvim-telescopt/telescope.nvim',
	}

	use {
		'nvim-telescope/telescope-ui-select.nvim',
		requires = 'nvim-telescope/telescope.nvim',
	}

	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	}
end

-- local colorok, colors = pcall(require, 'catppuccin.palettes')
-- if colorok then
-- 	colors = colors.get_palette()
--
-- 	local TelescopeColor = {
-- 		TelescopeMatching = { fg = colors.flamingo },
-- 		TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
-- 		TelescopePromptPrefix = { bg = colors.surface0 },
-- 		TelescopePromptNormal = { bg = colors.surface0 },
-- 		TelescopeResultsNormal = { bg = colors.mantle },
-- 		TelescopePreviewNormal = { bg = colors.mantle },
-- 		TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
-- 		TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
-- 		TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
-- 		TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
-- 		TelescopeResultsTitle = { fg = colors.mantle },
-- 		TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
-- 	}
--
-- 	for hl, col in pairs(TelescopeColor) do
-- 		vim.api.nvim_set_hl(0, hl, col)
-- 	end
-- end

return M
