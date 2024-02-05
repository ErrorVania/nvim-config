return {
	'akinsho/bufferline.nvim',
	event = 'User IsEditing',
	config = true,
	opts = {
		options = {
			offsets = {
				{
					filetype = 'NvimTree',
					text = "",
					highlight = 'Directory',
					text_align = 'center',
					separator = false
				},
				{
					filetype = 'undotree',
					text = "UndoTree",
					text_align = 'center'
				},
				{
					filetype = 'toggleterm',
					text = 'Terminal',
					text_align = 'center'
				}
			},
			diagnostics = 'nvim_lsp',
			diagnostics_indicator = function(count, level, _, ctx)
				if ctx.buffer:current() then
					return ''
				end
				local icon = level:match("error") and " " or ""
				return " " .. icon .. ' ' .. count
			end,
			separator_style = 'thin'
		}
	}
}
