import('mason', function(mason)
	mason.setup {
		ui = {
			border = 'none'
		},
		providers = {
			'mason.providers.client',
			'mason.providers.registry-api'
		}
	}
end)
