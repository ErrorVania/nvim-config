local M = {}

function M.config_ts()
	local ok, treesitter = pcall(require, 'nvim-treesitter.configs')
	if not ok then
		return
	end

	treesitter.setup{
		auto_install = true,
    	ensure_installed = {'c', 'cpp', 'lua', 'rust', 'help'},
    	highlight = {
        	enable = true,
        	additional_vim_regex_highlighting = false
    	},
    	rainbow = {
    		enable = true,
    		extended_mode = true
    	},
    	autotag = {
    		enable = true
    	}
	}
end

function M.run_ts()
	local ok, tsinstall = pcall(require, 'nvim-treesitter.install')
	if ok then
		tsinstall.update{with_sync = true}
	end
end


function M.setup(use)
	use {
		'nvim-treesitter/nvim-treesitter',
		requires = {
			{ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
			{ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter' }
		},
		run = M.run_ts,
		config = M.config_ts
	}
end

return M
