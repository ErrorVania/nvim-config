package.path = package.path .. "C:\\Users\\Joshua\\AppData\\Local\\nvim\\?.lua"
require('plugins')
require('vim-opts')

require("bufferline").setup{}
require("gitsigns").setup()
require("nvim-tree").setup()
require("Comment").setup()

require("nvim-lsp-installer").setup{}
require("lspconfig").sumneko_lua.setup{}

require("nvim-treesitter.configs").setup {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}




require("keymaps")
