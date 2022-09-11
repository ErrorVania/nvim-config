require('plugins')
require('vim-opts')

require("bufferline").setup{}
require("gitsigns").setup()
require("nvim-tree").setup()
require("Comment").setup()
require("nvim-lsp-installer").setup{}

require("lspconfigs")

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

require("nvim-autopairs").setup{}
require("trouble").setup{}
require("lualine").setup()
require("alpha").setup(require("alpha.themes.dashboard").config)
require("toggleterm").setup{
	direction = 'float'
}

local cmp = require("cmp")

cmp.event:on(
	'confirm_done',
	require("nvim-autopairs.completion.cmp").on_confirm_done()
)

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


require("keymaps")
