import('telescope', function(telescope)
	telescope.setup {
		defaults = {
			prompt_prefix = ' ',
			mappings = {
				i = {
					['<esc>'] = require('telescope.actions').close
				}
			}
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
end)
