local M = {}

local packer_ok, packer = pcall(require, 'packer')
if not packer_ok then
	return M
end

packer.init {
	git = {
		clone_timeout = 300
	},
	display = {
		open_fn = function()
			return require('packer.util').float { border = 'double' }
		end
	},
	profile = {
      enable = true,
      threshold = 1 -- the amount in ms that a plugin's load time must be over for it to be included in the profile
    }
}

packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'catppuccin/nvim'
	use { 'lewis6991/impatient.nvim', config = [[require('impatient')]] }

	require('configs.bufferline').setup(use)
	require('configs.statusline').setup(use)
	require('configs.telescope').setup(use)
	require('configs.git').setup(use)

	use 'famiu/bufdelete.nvim'
	use 'goolord/alpha-nvim'
	use 'folke/which-key.nvim'

	require('configs.treesitter').setup(use)
	require('configs.nvimtree').setup(use)

	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end,
		event = 'User IsEditing'
	}
	use { 'akinsho/toggleterm.nvim', tag = '*' }

	use 'williamboman/mason.nvim'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason-lspconfig.nvim'


	use { 'folke/trouble.nvim', event = 'LspAttach' }
	use { 'lukas-reineke/indent-blankline.nvim', event = 'BufWinEnter' }

	require('configs.completion').setup(use)

	use { 'ray-x/lsp_signature.nvim', event = 'LspAttach' }
	use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
	use 'mbbill/undotree'
	use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim', event = 'BufEnter',
		config = [[require('todo-comments').setup()]] }
	use 'stevearc/dressing.nvim'
	use { 'christoomey/vim-tmux-navigator', event = 'User IsTmuxSession' }
	use 'tiagovla/scope.nvim'
	use { 'rcarriga/nvim-notify', config = function() vim.notify = require('notify') end }
	use { 'RRethy/vim-illuminate', event = 'BufEnter' }
	use 'stevearc/overseer.nvim'
	use 'MTDL9/vim-log-highlighting'
	use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", event = 'LspAttach' }
end)

return M
