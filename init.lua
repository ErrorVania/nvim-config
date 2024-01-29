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

local function check_git_repo()
	local f = vim.fs.find('.git', { type = 'directory' })
	if f ~= {} then
		vim.api.nvim_exec_autocmds('User', { pattern = 'InGitRepo' })
		return true
	end
end

local function is_tmux_sess()
	if os.getenv('TMUX') then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsTmuxSession' })
		return true
	end
end

local function is_editing()
	if vim.fn.argc() > 0 or vim.o.insertmode or vim.o.modifiable then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsEditing' })
		return true
	end
end

local lazy_bootstrapped = bootstrap_lazy()

local lazy_ok, lazy = pcall(require, 'lazy')
if lazy_ok then
	vim.g.mapleader = ' '
	import'impatient'
	lazy.setup({ spec = 'plugins', opts = { install = { colorscheme = 'catppuccin-frappe' } } })
	if not lazy_bootstrapped and lazy_ok then
		require('vim-opts')
		require('lspconfigs')
		require('keymaps')
	end
end

vim.api.nvim_create_autocmd(
	'FileType',
	{
		pattern = { 'help', 'checkhealth', 'OverseerList', 'ImportManager' },
		command = [[nnoremap <buffer><silent> q :close<CR>]]
	}
)

vim.api.nvim_create_autocmd(
	'FileType',
	{
		pattern = { 'alpha' },
		command = [[nnoremap <buffer><silent> q :quit<CR>]]
	}
)

vim.api.nvim_create_autocmd(
	{ 'VimEnter', 'DirChanged' },
	{ callback = function() vim.schedule(check_git_repo) end }
)

vim.api.nvim_create_autocmd(
	{ 'VimEnter' },
	{ callback = function() vim.schedule(is_tmux_sess) end }
)

vim.api.nvim_create_autocmd(
	{ 'VimEnter', 'FileType' },
	{
		callback = function()
			local blacklist = {
				'mason',
				'packer'
			}
			for _, value in ipairs(blacklist) do
				if vim.bo.filetype == value then
					return
				end
			end
			vim.schedule(is_editing)
		end,
		pattern = '*'
	}
)
