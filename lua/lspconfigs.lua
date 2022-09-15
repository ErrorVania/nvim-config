local conf = require("lspconfig")
local caps = vim.lsp.protocol.make_client_capabilities()
caps = require("cmp_nvim_lsp").update_capabilities(caps)

local border = {
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
      {"*", "FloatBorder"},
}

local handlers = {
		["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
}


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
		"--query-driver=C:\\Users\\Joshua\\source\\repos\\billx\\toolchain\\bin\\arm-linux-gnueabihf-g++.exe"
	},
	handlers = handlers,
	capabilities = caps
}

conf.cmake.setup{
	capabilities = caps,
	handlers = handlers
}

conf.pyright.setup{
	capabilities = caps,
	handlers = handlers
}

conf.jsonls.setup{
	capabilities = caps,
	handlers = handlers
}
