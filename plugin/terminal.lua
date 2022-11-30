local ok, term = pcall(require, 'toggleterm')
if not ok then
	return
end

term.setup {
	direction = 'float',
	float_opts = {
		border = 'single'
	}
}
