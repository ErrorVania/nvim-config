--[[
local luadev = require("lua-dev").setup({
	lspconfig = {
		capabilities = caps,
		handlers = handlers
	}
})
conf.sumneko_lua.setup{
	luadev
}

conf.clangd.setup{
	cmd = {
		"clangd",
		"--enable-config",
		"--all-scopes-completion",
		"--background-index",
		"--header-insertion=never",
--		"--query-driver=C:\\Users\\Joshua\\source\\repos\\billx\\toolchain\\bin\\arm-linux-gnueabihf-g++.exe"
		"--query-driver=*"
	},
	handlers = handlers,
	capabilities = caps
}
 ]]

local caps = require('cmp_nvim_lsp').default_capabilities()
local handlers = {
		['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
}

require('mason-lspconfig').setup_handlers{
	function (server_name)
		require('lspconfig')[server_name].setup{
			capabilities = caps,
			handlers = handlers
		}
	end
}