import('mason', function(mason)
	mason.setup {
		ui = {
			border = 'none'
		},
		providers = {
			'mason.providers.client',
			'mason.providers.registry-api'
		}
	}
end)

import('mason-nvim-dap', function(d)
	local dap = require('dap')
	local dapui = require('dapui')

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end


	d.setup {
		automatic_setup = true
	}
	d.setup_handlers {
		function(source)
			-- ...
			require('mason-nvim-dap.automatic_setup')(source)
		end,
		codelldb = function(source)
			dap.adapters.lldb = {
				type = 'server',
				host = '127.0.0.1',
				port = '${port}',
				executable = {
					command = 'codelldb',
					args = { '--port', '${port}' }
				}
			}
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/')
					end,
					cwd = '${workspaceFolder}',
					stopOnEntry = false,
					runInTerminal = true,
				},
			}
		end
	}
	dapui.setup()
end)
