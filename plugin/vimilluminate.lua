local ok, illuminate = pcall(require, 'illuminate')
if not ok then
	return
end

illuminate.configure {
	providers = {
		'lsp',
		'treesitter'
	}
}

local IlluminateColor = {
	IlluminatedWordRead = { link = 'Visual' },
	IlluminatedWordWrite = { link = 'Visual' },
}

for hl, col in pairs(IlluminateColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
