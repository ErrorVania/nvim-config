local M = {}

function import(modules, callback)
	if modules ~= nil then
		local result = nil
		if type(modules) == 'table' then
			result = {}
			for _, k in ipairs(modules) do
				local ok, m = pcall(require, modules[k])
				if not ok then
					return
				end
				result[modules[k]] = m
			end
		elseif type(modules) == 'string' then
			local ok, m = pcall(require, modules)
			if ok then
				result = m
			end
		end
		if callback ~= nil then
			callback(result)
		end
	end
end

import('packer', function(packer)
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
		use { 'lewis6991/impatient.nvim' }
		import('impatient')

		use {
			'akinsho/bufferline.nvim',
			tag = "v3.*",
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = [[import'configs.bufferline']],
			event = 'User IsEditing'
		}

		use {
			'nvim-lualine/lualine.nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = [[import'configs.statusline']]
		}

		use 'nvim-telescope/telescope-file-browser.nvim'
		use 'nvim-telescope/telescope-project.nvim'
		use 'nvim-telescope/telescope-ui-select.nvim'

		use {
			'nvim-telescope/telescope-fzf-native.nvim',
			run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
		}

		use {
			'nvim-telescope/telescope.nvim',
			tag = '0.1.0',
			requires = { 'nvim-lua/plenary.nvim' },
			config = [[import'configs.telescope']]
		}


		use 'famiu/bufdelete.nvim'
		use 'goolord/alpha-nvim'
		use 'folke/which-key.nvim'

		use 'p00f/nvim-ts-rainbow'
		use 'windwp/nvim-ts-autotag'

		use {
			'nvim-treesitter/nvim-treesitter',
			run = function()
				import('nvim-treesitter.install', function(ts)
					ts.update { with_sync = true }
				end)
			end,
			config = [[import'configs.treesitter']]
		}

		use {
			'nvim-tree/nvim-tree.lua',
			requires = 'nvim-tree/nvim-web-devicons',
			config = [[import'configs.nvimtree']]
		}

		use {
			'numToStr/Comment.nvim',
			config = [[import('Comment', function(c) c.setup() end)]],
			event = 'User IsEditing'
		}
		use { 'akinsho/toggleterm.nvim', tag = '*' }


		use {
			'williamboman/mason.nvim',
			config = [[import'configs.mason']]
		}

		use { 'neovim/nvim-lspconfig' }

		use {
			'williamboman/mason-lspconfig.nvim',
			config = [[import('mason-lspconfig', function(m) m.setup() end)]]
		}

		use {
			'lewis6991/gitsigns.nvim',
			config = [[import('gitsigns', function(gs) gs.setup() end)]],
			event = 'User InGitRepo',
			after = 'nvim-notify'
		}

		use {
			'akinsho/git-conflict.nvim',
			tag = '*',
			config = [[import('git-conflict', function(gs) gs.setup() end)]],
			event = 'User InGitRepo'
		}

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
		use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", event = 'LspAttach' }

		use { 'fgheng/winbar.nvim' }
		use { 'shaunsingh/nord.nvim' }
	end)
end)

return M
