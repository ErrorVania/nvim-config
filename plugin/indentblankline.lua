local ok, ibl = pcall(require, 'indent_blankline')
if not ok then
	return
end

ibl.setup{
	show_end_of_line = true,
	space_char_blankline = ' '
}
