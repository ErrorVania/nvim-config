local caps = require('cmp_nvim_lsp').default_capabilities()
local handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
}

local navicok, navic = pcall(require, 'nvim-navic')

local function attach(client, bufnr)
	if navicok then
		if client.server_capabilities.documentSymbolProvider then
			navic.attach(client, bufnr)
		end
	end
end

require('mason-lspconfig').setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = caps,
			handlers = handlers,
			on_attach = attach
		}
	end,
	["sumneko_lua"] = function()
		require('lspconfig').sumneko_lua.setup {
			capabilities = caps,
			handlers = handlers,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", 'import' }
					}
				}
			},
			on_attach = attach
		}
	end,
	["clangd"] = function()
		require('lspconfig').clangd.setup {
			cmd = {
				"clangd",
				"--enable-config",
				"--all-scopes-completion",
				"--background-index",
				"--header-insertion=never",
				"--query-driver=*"
			},
			handlers = handlers,
			capabilities = caps,
			on_attach = attach
		}

	end
}
