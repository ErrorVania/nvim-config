local function extension_loader(ext)
	return function()
		local tele = require('telescope')
		tele.load_extension(ext)
	end
end

return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = 'VeryLazy',
		config = function ()
			local tele = require('telescope')
			tele.setup{
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
					buffers = require('telescope.themes').get_dropdown {
						previewer = false
					},
					git_files = require('telescope.themes').get_dropdown {
						previewer = false
					},
					git_branches = require('telescope.themes').get_dropdown {
						previewer = true
					},
					git_status = require('telescope.themes').get_dropdown {
						previewer = true
					},
					colorscheme = require('telescope.themes').get_dropdown {
						previewer = false,
						prompt_prefix = ' ',
						prompt_title = 'Themes'
					}
				}
			}
		end
	},
	-- telescope extensions go here
	{
		'nvim-telescope/telescope-file-browser.nvim',
		requires = { 'nvim-telescope/telescope.nvim' },
		after = 'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		config = extension_loader('file_browser')
	},
	{
		'nvim-telescope/telescope-project.nvim',
		requires = { 'nvim-telescope/telescope.nvim' },
		after = 'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		config = extension_loader('project')
	},
	{
		'nvim-telescope/telescope-ui-select.nvim',
		requires = { 'nvim-telescope/telescope.nvim' },
		after = 'nvim-telescope/telescope.nvim',
		event = 'VeryLazy',
		config = extension_loader('ui-select')
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		requires = { 'nvim-telescope/telescope.nvim' },
		after = 'nvim-telescope/telescope.nvim',
		build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		event = 'VeryLazy',
		config = extension_loader('fzf')
	},
	{
		'jedrzejboczar/toggletasks.nvim',
		requires = { 'akinsho/toggleterm.nvim', 'nvim-telescope/telescope.nvim' },
		after = {'nvim-telescope/telescope.nvim', 'akinsho/toggleterm.nvim'},
		event = 'VeryLazy',
		config = function()
			require('toggletasks').setup{}
			extension_loader('toggletasks')()
		end
	}
}
