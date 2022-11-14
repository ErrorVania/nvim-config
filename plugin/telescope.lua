local ok, telescope = pcall(require, 'telescope')
if not ok then
	return
end

telescope.setup{
	pickers = {

	},
	extensions = {
		['ui-select'] = {
			require('telescope.themes').get_dropdown{}
		}
	}
}

telescope.load_extension('projects')
telescope.load_extension('file_browser')

