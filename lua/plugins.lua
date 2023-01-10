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
	use { 'miversen33/import.nvim', as = 'import'}

	use {
		'akinsho/bufferline.nvim',
		tag = "v3.*",
		requires = {'kyazdani42/nvim-web-devicons', 'import'},
		config = [[require'configs.bufferline']],
		event = 'User IsEditing'
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', 'import' },
		config = [[require'configs.statusline']]
	}

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

	require('configs.lsp').setup(use)

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
	use { 'fgheng/winbar.nvim' }
	use {
		'andersevenrud/nordic.nvim',
		config = function()
			-- The table used in this example contains the default settings.
			-- Modify or remove these to your liking (this also applies to alternatives below):
			require('nordic').colorscheme({
				-- Underline style used for spelling
				-- Options: 'none', 'underline', 'undercurl'
				underline_option = 'none',

				-- Italics for certain keywords such as constructors, functions,
				-- labels and namespaces
				italic = true,

				-- Italic styled comments
				italic_comments = false,

				-- Minimal mode: different choice of colors for Tabs and StatusLine
				minimal_mode = false,

				-- Darker backgrounds for certain sidebars, popups, etc.
				-- Options: true, false, or a table of explicit names
				-- Supported: terminal, qf, vista_kind, packer, nvim-tree, telescope, whichkey
				alternate_backgrounds = true,
			})
		end
	}
end)

return M
