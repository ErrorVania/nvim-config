vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- bootstrap packer - requires git
local bootstrap_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		if fn.executable('git') ~= 1 then
			print 'could not find git executable, cannot bootstrap packer!'
			os.exit()
		end

		fn.system {
			'git', 'clone', '--depth', '1',
			'https://github.com/wbthomason/packer.nvim', install_path
		}
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrapped = bootstrap_packer()

local packer_ok, packer = pcall(require, 'packer')
if packer_ok then
	require('plugins')

	if not packer_bootstrapped and packer_ok then
		require('vim-opts')
		require("lspconfigs")
		require("keymaps")
	else
		packer.sync()
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
	'BufWritePost',
	{
		pattern = { 'plugins.lua' },
		callback = function()
			vim.cmd [[luafile %]]
			packer.compile()
			vim.notify('Reloaded Config')
		end
	}
)

local function check_git_repo()
	local f = vim.fs.find('.git', { type = 'directory' })
	if f ~= {} then
		vim.api.nvim_exec_autocmds('User', { pattern = 'InGitRepo' })
		return true
	end
end

local function is_tmux_sess()
	if os.getenv('TMUX') then
		vim.api.nvim_exec_autocmds("User", { pattern = "IsTmuxSession" })
		return true
	end
end

vim.api.nvim_create_autocmd(
	{ "VimEnter", "DirChanged" },
	{ callback = function() vim.schedule(check_git_repo) end }
)

vim.api.nvim_create_autocmd(
	{ "VimEnter" },
	{ callback = function() vim.schedule(is_tmux_sess) end }
)

local function is_editing()
	if vim.fn.argc() > 0 or vim.o.insertmode or vim.o.modifiable then
		vim.api.nvim_exec_autocmds("User", { pattern = "IsEditing" })
		return true
	end
end

vim.api.nvim_create_autocmd(
	{ "VimEnter", "FileType" },
	{
		callback = function()
			local blacklist = {
				"mason",
				"packer"
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

local IlluminateColor = {
	IlluminatedWordRead = { link = 'Visual' },
	IlluminatedWordWrite = { link = 'Visual' },
	IlluminatedWordText = { link = 'Visual' }
}

for hl, col in pairs(IlluminateColor) do
	vim.api.nvim_set_hl(0, hl, col)
end
