local ok, bufferline = pcall(require, 'bufferline')
if not ok then
	return
end

bufferline.setup {
	options = {
		offsets = {
        	{
				filetype = 'NvimTree',
				text = "Explorer",
				highlight = 'Directory',
				text_align = 'center'
            },
            {
				filetype = 'undotree',
				text = "UndoTree",
				text_align = 'center'
			}
        },
        diagnostics = 'nvim_lsp'
    }
}
