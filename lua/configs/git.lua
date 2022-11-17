local M = {}

function M.signs_config()
	local signs_ok, gitsigns = pcall(require, 'gitsigns')
	if signs_ok then
		gitsigns.setup()
	else
	end
end

function M.conflict_config()
	local conflict_ok, gitconflict = pcall(require, 'git-conflict')
	if conflict_ok then
		gitconflict.setup()
	end
end

function M.setup(use)
	use {
		'lewis6991/gitsigns.nvim',
		config = M.signs_config,
		event = 'User InGitRepo',
		after = 'nvim-notify' 
	}

	use {
		'akinsho/git-conflict.nvim',
		tag = '*',
		config = M.conflict_config,
		event = 'User InGitRepo'
	}

end

return M
