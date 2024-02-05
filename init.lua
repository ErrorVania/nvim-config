import = require'import'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- bootstrap lazy - requires git
local bootstrap_lazy = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/lazy/lazy.nvim'
	if not vim.loop.fs_stat(install_path) then
		if fn.executable('git') ~= 1 then
			print 'could not find git executable, cannot bootstrap lazy!'
			os.exit()
		end

		fn.system {
			'git', 'clone', '--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git', '--branch=stable', install_path
		}
		vim.opt.rtp:prepend(install_path)
		return true
	end
	vim.opt.rtp:prepend(install_path)
	return false
end

local lazy_bootstrapped = bootstrap_lazy()

local lazy_ok, lazy = pcall(require, 'lazy')
if lazy_ok then
	vim.g.mapleader = ' '
	import'impatient'
	lazy.setup({ spec = 'plugins', opts = { install = { colorscheme = 'catppuccin-frappe' } } })
	if not lazy_bootstrapped and lazy_ok then
		local autocmds = require('autocmds')
		for _, cmd in pairs(autocmds) do
			vim.api.nvim_create_autocmd(cmd[1],cmd[2])
		end
		require('vim-opts')
		require('lspconfigs')
		require('keymaps')
	end
end

