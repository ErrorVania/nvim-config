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
			return require('packer.util').float {border = 'rounded'}
		end
	}
}

packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	-- use 'Mofiqul/dracula.nvim'
	-- use 'joshdick/onedark.vim'
	-- use 'folke/tokyonight.nvim'
	use 'catppuccin/nvim'
	use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons' }
	use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-file-browser.nvim',
			'ahmedkhalf/project.nvim'
		}
	}
	use {'lewis6991/gitsigns.nvim', event = 'User InGitRepo'}
	use 'goolord/alpha-nvim'
	use 'folke/which-key.nvim'
	use {
		'nvim-treesitter/nvim-treesitter',
		requires = {'p00f/nvim-ts-rainbow', after= 'nvim-treesitter'},
		run = function()
			require('nvim-treesitter.install').update({with_sync = true})
		end
	}
	use {
		'nvim-tree/nvim-tree.lua',
		requires = 'nvim-tree/nvim-web-devicons'
	}
	use {
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	}
	use { 'akinsho/toggleterm.nvim', tag = '*' }

	use 'williamboman/mason.nvim'
	use 'neovim/nvim-lspconfig'
	use 'williamboman/mason-lspconfig.nvim'


	use {'jackguo380/vim-lsp-cxx-highlight', event = {'FileType cpp', 'FileType c'}}
	use {'folke/trouble.nvim', event = 'LspAttach'}
	use {'lukas-reineke/indent-blankline.nvim', event = 'BufWinEnter'}

	use {
		'hrsh7th/nvim-cmp',
		requires = {
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
			{'hrsh7th/cmp-path', after = 'nvim-cmp'},
			{'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
			{'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'},
			{'L3MON4D3/LuaSnip', after = 'nvim-cmp'},
			{'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup{}]]}
		}
	}

	use {'ray-x/lsp_signature.nvim', event = 'LspAttach'}
	use {'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix'}
	use 'mbbill/undotree'
	use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim', event = 'BufEnter'}
	use {'akinsho/git-conflict.nvim', tag = '*', event = 'User InGitRepo'}
	use 'stevearc/dressing.nvim'
	use 'christoomey/vim-tmux-navigator'
	use 'tiagovla/scope.nvim'
	use {'rcarriga/nvim-notify', config = function() vim.notify = require('notify') end }
	use {'RRethy/vim-illuminate', event = 'BufEnter'}
	use 'stevearc/overseer.nvim'
	use 'MTDL9/vim-log-highlighting'
	use 'windwp/nvim-ts-autotag'
	use 'nvim-telescope/telescope-ui-select.nvim'
	use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }
end)

return M
