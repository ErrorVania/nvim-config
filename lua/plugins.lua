return {
	{ 'lewis6991/impatient.nvim', lazy = false, priority = 1000 },
	{ 'kyazdani42/nvim-web-devicons', lazy = true },
	{'famiu/bufdelete.nvim', lazy = true },
	{
		'nvim-tree/nvim-tree.lua',
		event = 'VeryLazy',
		config = function() import 'configs.nvimtree' end
	},
	{ 'numToStr/Comment.nvim', config = true, event = 'User IsEditing' },
	{ 'akinsho/toggleterm.nvim', config = function() import 'configs.terminal' end },
	{
		'williamboman/mason.nvim',
		config = true,
		opts = {
			ui = {
				border = 'none'
			},
			providers = {
				'mason.providers.client',
				'mason.providers.registry-api'
			}
		}
	},
	{ 'lewis6991/gitsigns.nvim', config = true, event = 'User InGitRepo', after = 'nvim-notify' },
	{ 'akinsho/git-conflict.nvim', config = true, event = 'User InGitRepo' },
	{
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufWinEnter',
		main = 'ibl',
		config = true,
		opts = {
			scope = {
				enabled = false
			}
		}
	},
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'L3MON4D3/LuaSnip' },
		},
		event = 'VeryLazy',
		config = require('configs.completion').configure_cmp,
	},
	{
		'windwp/nvim-autopairs',
		requires = { 'hrsh7th/nvim-cmp' },
		after = 'nvim-cmp',
		config = require('configs.completion').setup_autopairs
	},

	{ 'RishabhRD/nvim-cheat.sh', dependencies = { 'RishabhRD/popfix' }, lazy = true, cmd = 'Cheat' },
	'mbbill/undotree',
	{
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		event = 'VeryLazy',
		config = true
	},
	'stevearc/dressing.nvim',
	{ 'christoomey/vim-tmux-navigator', event = 'User IsTmuxSession' },
	{ 'tiagovla/scope.nvim', config = function() import('scope', function(s) s.setup() end) end },
	{ 'rcarriga/nvim-notify', config = function() vim.notify = require('notify') end },
	{ 'RRethy/vim-illuminate', event = 'BufEnter', config = function() import 'configs.vimilluminate' end },
	{ 'fgheng/winbar.nvim' },
	{ 'shaunsingh/nord.nvim', lazy = true },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		build = function()
			import('catppuccin',
				function(c)
					c.compile()
					import('configs.theme', function(t)
						t.save_theme('catppuccin-frappe')
						t.load_theme()
					end)
				end)
		end,
		priority = 999
	},
	{ 'navarasu/onedark.nvim', lazy = true },
	{ 'karb94/neoscroll.nvim', config = true, event = 'VeryLazy' },
}
