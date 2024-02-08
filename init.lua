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
if not lazy_ok then
	return
end

vim.g.mapleader = ' '
import'impatient'
lazy.setup({ spec = 'plugins', opts = { install = { colorscheme = 'catppuccin-frappe' } } })

if lazy_bootstrapped then
	return
end

-- autocommands
local autocmds = require 'autocmds'
autocmds.define_autocmds{
	{
		'FileType',
		{
			pattern = { 'help', 'checkhealth', 'OverseerList', 'ImportManager' },
			command = [[nnoremap <buffer><silent> q :close<CR>]]
		}
	},
	{
		'FileType',
		{
			pattern = { 'alpha' },
			command = [[nnoremap <buffer><silent> q :quit<CR>]]
		}
	},
	{
		{ 'VimEnter', 'DirChanged' },
		{ callback = function() vim.schedule(autocmds.check_git_repo) end }
	},
	{
		{ 'VimEnter' },
		{ callback = function() vim.schedule(autocmds.is_tmux_sess) end }
	},
	{
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
				vim.schedule(autocmds.is_editing)
			end,
			pattern = '*'
		}
	}
}

-- vim options
vim.opt.timeoutlen = 0
vim.wo.number = true
vim.g.encoding = 'UTF-8'
vim.opt.termguicolors = true
vim.o.cursorline = true
vim.g.nobackup = true
vim.g.nowritebackup = true
vim.opt.mouse = 'a'
vim.cmd("filetype plugin indent on")
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.pumheight = 10
vim.opt.fillchars = 'eob: '
vim.cmd("set completeopt=menu,menuone,noselect")

require('configs.theme').load_theme()

-- keymaps
vim.keymap.set('n', '<Space>', '', {}) --leader

local function nmap(mode, keys, command)
	return vim.keymap.set(mode, keys, command, { noremap = true })
end

nmap('n', '<C-s>', '<cmd>w<cr>')
nmap('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>')
nmap('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>')

nmap('n', '<S-k>', vim.lsp.buf.hover)
nmap('n', 'gd', vim.lsp.buf.declaration)
nmap('n', 'gD', vim.lsp.buf.definition)


nmap('n', '<C-h>', '<C-W>h')
nmap('n', '<C-j>', '<C-W>j')
nmap('n', '<C-k>', '<C-W>k')
nmap('n', '<C-l>', '<C-W>l')

