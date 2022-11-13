local ok, alpha = pcall(require, 'alpha')
if not ok then
	return
end

local dashboard = require('alpha.themes.dashboard')


dashboard.section.buttons.val = {
	dashboard.button('e', ' New file'),
	dashboard.button('SPC f f', ' Find file'),
	dashboard.button('SPC f h', ' Recent files'),
	dashboard.button('SPC f p', 'ﴬ Projects'),
	dashboard.button('SPC N c', '漣Settings')
}


alpha.setup(dashboard.opts)

