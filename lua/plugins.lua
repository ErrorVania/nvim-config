function import(modules, callback)
	if modules ~= nil then
		local result = nil
		if type(modules) == 'table' then
			result = {}
			for k = 1, #modules do
				local ok, m = pcall(require, modules[k])
				if not ok then
					modules[k] = nil
				else
					result[modules[k]] = m
				end
			end
		elseif type(modules) == 'string' then
			local ok, m = pcall(require, modules)
			if ok then
				result = m
			end
		end
		if callback ~= nil and result ~= nil then
			callback(result)
		end
	end
end

return {
	{
		'lewis6991/impatient.nvim',
		lazy = false,
		priority = 1000,
		config = function(lp, opts) require 'impatient' end
	},
	{ 'kyazdani42/nvim-web-devicons', lazy = true },
	{
		'akinsho/bufferline.nvim',
		tag = '*',
		config = function(lp, opts) import 'configs.bufferline' end,
		event = 'User IsEditing'
	},

	{
		'nvim-lualine/lualine.nvim',
		config = function(lp, opts) import 'configs.statusline' end
	},

	'nvim-telescope/telescope-file-browser.nvim',
	'nvim-telescope/telescope-project.nvim',
	'nvim-telescope/telescope-ui-select.nvim',

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build =
		'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
	},

	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function(lp, opts) import 'configs.telescope' end
	},


	'famiu/bufdelete.nvim',
	{ 'folke/neodev.nvim',            event = 'LspAttach' },
	{ 'goolord/alpha-nvim',           config = function(lp, opts) import 'configs.dashboardmenu' end },
	{ 'folke/which-key.nvim',         config = function(lp, opts) import 'configs.whichkey' end },

	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { { 'HiPhish/nvim-ts-rainbow2', after = 'nvim-treesitter' },
			{ 'windwp/nvim-ts-autotag',   after = 'nvim-treesitter' } },
		config = function(lp, opts) import 'configs.treesitter' end
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
	{ 'akinsho/toggleterm.nvim', tag = '*',                                 config = function(lp, opts) import 'configs.terminal' end },
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
		tag = '*',
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
		config = true,
		opts = {
			show_end_of_line = true,
			space_char_blankline = ' '
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
	{ 'RishabhRD/nvim-cheat.sh',  requires = { 'RishabhRD/popfix' } },
	'mbbill/undotree',
	{
		'folke/todo-comments.nvim',
		requires = 'nvim-lua/plenary.nvim',
		event = 'BufEnter',
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
	{ 'shaunsingh/nord.nvim' },
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
		end
	},
	'navarasu/onedark.nvim',
	{
		'karb94/neoscroll.nvim', config = true
	}
}
