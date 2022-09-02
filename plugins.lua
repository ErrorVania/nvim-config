local Plug = vim.fn['plug#']

vim.call('plug#begin')
	Plug 'kyazdani42/nvim-web-devicons'
	Plug('akinsho/bufferline.nvim', { tag = 'v2.*' })
	Plug 'kyazdani42/nvim-tree.lua'
	Plug 'Mofiqul/dracula.nvim'
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
	Plug 'voldikss/vim-floaterm'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'nvim-lua/plenary.nvim'
	Plug('nvim-telescope/telescope.nvim', { tag = '0.1.0' })
	Plug 'kdheepak/lazygit.nvim'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'neovim/nvim-lspconfig'
	Plug 'jackguo380/vim-lsp-cxx-highlight'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'numToStr/Comment.nvim'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'L3MON4D3/LuaSnip'
	Plug 'saadparwaiz1/cmp_luasnip'
vim.call('plug#end')


