--[[ local Plug = vim.fn['plug#']

vim.call('plug#begin')
-- Everything else
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
	Plug 'windwp/nvim-autopairs'
	Plug 'folke/lua-dev.nvim'
vim.call('plug#end') ]]

-- bootstrap packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
	   fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	   vim.cmd [[packadd packer.nvim]]
	   return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
-- Themes
	use 'Mofiqul/dracula.nvim'
	use 'joshdick/onedark.vim'
	use 'folke/tokyonight.nvim'
-- The very important stuff
	use { 'lewis6991/impatient.nvim', config = function() require('impatient') end }
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons', config = function() require('bufferline').setup() end }
	use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons', config = function() require('lualine').setup{ options = { disabled_filetypes = { 'alpha' } } } end }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' }
	use { "nvim-telescope/telescope-file-browser.nvim", config = function() require('telescope').load_extension 'file_browser' end }
	use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
	use { 'goolord/alpha-nvim', config = function () require'alpha'.setup(require'alpha.themes.dashboard'.config) end }
	use { 'folke/which-key.nvim', config = function() require('which-key').setup{ window = { border = 'single' } } end }
-- Non-LSP Stuff
	use { 'nvim-treesitter/nvim-treesitter', config = function()
		require('nvim-treesitter.configs').setup{
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false
			}
		}
		end,
		run = function() require('nvim-treesitter.install').update({ with_sync = true}) end
	}
	use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons', config = function() require('nvim-tree').setup() end }
	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
	use { 'akinsho/toggleterm.nvim', tag = '*', config = function() require('toggleterm').setup{ direction = 'float' } end }

-- Everything else
	use { 'williamboman/mason.nvim', config = function() require('mason').setup() end }
	use 'neovim/nvim-lspconfig'
	use { 'williamboman/mason-lspconfig.nvim', config = function() require('mason-lspconfig').setup() end }

	use 'jackguo380/vim-lsp-cxx-highlight'
	use 'folke/trouble.nvim'


	if packer_bootstrap then
	   require('packer').sync()
	end
end )

function _lazygit_toggle()
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
	lazygit:toggle()
end



--[[
require("nvim-autopairs").setup{}
require("trouble").setup{}

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	mapping = cmp.mapping.preset.insert(
		{
			['<C-Space>'] = cmp.mapping.complete(),
			['<cr>'] = cmp.mapping.confirm({ select = true})
		}
	),
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	sources = cmp.config.sources({{ name = "nvim_lsp" }, { name = "luasnip" }}, {{ name = "buffer" }})
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

cmp.event:on(
	'confirm_done',
	require("nvim-autopairs.completion.cmp").on_confirm_done()
)


 ]]





