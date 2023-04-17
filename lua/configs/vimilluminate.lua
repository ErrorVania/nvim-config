import('illuminate', function(i)
	i.configure {
		providers = {
			'lsp',
			'treesitter'
		}
	}

	local IlluminateColor = {
		IlluminatedWordRead = { link = 'Visual' },
		IlluminatedWordWrite = { link = 'Visual' },
		IlluminatedWordText = { link = 'Visual' }
	}

	for hl, col in pairs(IlluminateColor) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end)
