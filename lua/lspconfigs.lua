local caps = require('cmp_nvim_lsp').default_capabilities()
local handlers = {
	['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
}

local function attach(client, bufnr)
	import('nvim-navic', function(nav)
		if client.server_capabilities.documentSymbolProvider then
			nav.attach(client, bufnr)
		end
	end)

	import('lsp_signature', function(ls)
		ls.on_attach({
			bind = true,
			handler_opts = {
				border = "single"
			},
			hint_enable = false
		}, bufnr)
	end)
end

import('mason-lspconfig', function(mlsp)
	mlsp.setup_handlers {
		function(server_name)
			require('lspconfig')[server_name].setup {
				capabilities = caps,
				handlers = handlers,
				on_attach = attach
			}
		end,
		["lua_ls"] = function()
			require('lspconfig').lua_ls.setup {
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
end)
