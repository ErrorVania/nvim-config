import('bufferline', function(bufferline)
	bufferline.setup {
		options = {
			offsets = {
				{
					filetype = 'NvimTree',
					text = "File Explorer",
					highlight = 'Directory',
					text_align = 'center'
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
			separator_style = 'slant'
		}
	}
end)

