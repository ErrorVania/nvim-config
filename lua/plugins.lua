return {
	{
		'lewis6991/impatient.nvim',
		lazy = false,
		priority = 1000,
	},
	{ 'kyazdani42/nvim-web-devicons', lazy = true },
	{
		'akinsho/bufferline.nvim',
		config = function(lp, opts) import 'configs.bufferline' end,
		event = 'User IsEditing'
	},

	{
		'nvim-lualine/lualine.nvim',
		config = function(lp, opts) import 'configs.statusline' end
	},





	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-file-browser.nvim', lazy = true },
			{ 'nvim-telescope/telescope-project.nvim',      lazy = true },
			{ 'nvim-telescope/telescope-ui-select.nvim',    lazy = true },
			{ 'nvim-telescope/telescope-fzf-native.nvim',   build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build', lazy = false }
		},
		config = function(lp, opts) import 'configs.telescope' end
	},


	'famiu/bufdelete.nvim',
	{ 'folke/neodev.nvim',            event = 'LspAttach' },
	{ 'goolord/alpha-nvim',           config = function(lp, opts) import 'configs.dashboardmenu' end },
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function(lp, opts)
			require 'configs.whichkey'
		end
	},

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { { 'HiPhish/nvim-ts-rainbow2', after = 'nvim-treesitter' },
			{ 'windwp/nvim-ts-autotag',   after = 'nvim-treesitter' } },
		config = function(lp, opts) import 'configs.treesitter' end,
		build = function()
			import('nvim-treesitter.install', function(t)
				t.update {}
			end)
		end
	},

	{
		'nvim-tree/nvim-tree.lua',
		config = function(lp, opts) import 'configs.nvimtree' end
	},

	{
		'numToStr/Comment.nvim',
		config = true,
		event = 'User IsEditing'
	},
	{ 'akinsho/toggleterm.nvim', config = function(lp, opts) import 'configs.terminal' end },
	{
		'williamboman/mason.nvim',
		config = function(lp, opts) import 'configs.mason' end
	},

	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = { 'neovim/nvim-lspconfig' },
		config = true
	},

	'mfussenegger/nvim-dap',
	{ "rcarriga/nvim-dap-ui",    dependencies = { "mfussenegger/nvim-dap" } },
	'jay-babu/mason-nvim-dap.nvim',

	{
		'lewis6991/gitsigns.nvim',
		config = true,
		event = 'User InGitRepo',
		after = 'nvim-notify'
	},

	{
		'akinsho/git-conflict.nvim',
		config = true,
		event = 'User InGitRepo'
	},
	{
		'folke/trouble.nvim',
		event = 'LspAttach',
		config = true
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufWinEnter',
		main = 'ibl',
		config = true
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
		config = function(lp, opts) require('configs.completion').configure_cmp() end,
		--event = 'User IsEditing'
	},

	{
		'windwp/nvim-autopairs',
		requires = { 'hrsh7th/nvim-cmp' },
		after = 'nvim-cmp',
		config = function(lp, opts) require('configs.completion').setup_autopairs() end
	},

	{ 'ray-x/lsp_signature.nvim', event = 'LspAttach' },
	{ 'RishabhRD/nvim-cheat.sh',  dependencies = { 'RishabhRD/popfix' }, lazy = true, cmd = 'Cheat' },
	'mbbill/undotree',
	{
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		event = 'VeryLazy',
		config = true
	},
	'stevearc/dressing.nvim',
	{ 'christoomey/vim-tmux-navigator', event = 'User IsTmuxSession' },
	{ 'tiagovla/scope.nvim',            config = function() import('scope', function(s) s.setup() end) end },
	{ 'rcarriga/nvim-notify',           config = function() vim.notify = require('notify') end },
	{
		'RRethy/vim-illuminate',
		event = 'BufEnter',
		config = function(lp, opts) import 'configs.vimilluminate' end
	},
	{
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
		event =
		'LspAttach'
	},

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
	{
		'karb94/neoscroll.nvim', config = true
	}
}
