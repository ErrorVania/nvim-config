local Plug = vim.fn['plug#']

vim.call('plug#begin')
	Plug 'kyazdani42/nvim-web-devicons'
	Plug('akinsho/bufferline.nvim', { tag = 'v2.*' })
	Plug 'kyazdani42/nvim-tree.lua'
	Plug 'Mofiqul/dracula.nvim'
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
	Plug 'akinsho/toggleterm.nvim'
	Plug 'nvim-lualine/lualine.nvim'
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
	Plug 'folke/which-key.nvim'
	Plug 'windwp/nvim-autopairs'
	Plug 'folke/lua-dev.nvim'
	Plug 'folke/trouble.nvim'
	Plug 'goolord/alpha-nvim'
	Plug 'lewis6991/impatient.nvim'
	Plug  'joshdick/onedark.vim'
	Plug 'folke/tokyonight.nvim'
	Plug 'dbgx/lldb.nvim'
vim.call('plug#end')

require("bufferline").setup{}
require("gitsigns").setup()
require("nvim-tree").setup()
require("nvim-autopairs").setup{}
require("trouble").setup{}
require("impatient").enable_profile()
require("lualine").setup{
	options = {
		disabled_filetypes = {
			'alpha'
		}
	}
}
require("Comment").setup()
require("toggleterm").setup{
	direction = 'float'
}

require("alpha").setup(require("alpha.themes.dashboard").config)

require("nvim-lsp-installer").setup{}

require("nvim-treesitter.configs").setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

require("which-key").setup{
	window = {
		border = "single"
	}
}

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


require("which-key").register(
	{
		f = {
			name = "File",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			g = { "<cmd>Telescope git_files<cr>", "Git Files" },
			h = { "<cmd>Telescope oldfiles<cr>", "Recent Files" }
		},
		c = {
			name = "Build/Run",
			b = { '<cmd>TermExec cmd="cmake --build build/" direction=tab<cr>', "Run cmake build in 'build/'"}
		},
		l = {
			name = "LSP",
			d = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Go to Declaration' },
			D = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Go to Definition' },
			r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Go to References' },
			R = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' }
		}
	},
	{ prefix = "<leader>" }
)





