return {
	'goolord/alpha-nvim',
	config = function(lp, opts)
		local alpha = require('alpha')
		local dashboard = require('alpha.themes.dashboard')

		dashboard.section.buttons.val = {
			dashboard.button('e', ' New file', ':ene<cr>'),
			dashboard.button('SPC f f', ' Find file'),
			dashboard.button('SPC f h', ' Recent files'),
			dashboard.button('SPC f p', 'ﴬ Projects'),
			dashboard.button('SPC N c', '漣 Settings')
		}

		alpha.setup(dashboard.opts)
	end
}
