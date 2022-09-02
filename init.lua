package.path = package.path .. "C:\\Users\\Joshua\\AppData\\Local\\nvim\\?.lua"
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


require("keymaps")
