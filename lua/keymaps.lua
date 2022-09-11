-- local map = vim.api.nvim_set_keymap
local map = vim.keymap.set

-- leader
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = { noremap = true }

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', options)
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>', options)
map('n', '<leader>n', '<cmd>NvimTreeToggle<cr>', options)
map('n', '<leader>gg', '<cmd>LazyGit<cr>', options)
map('n', '<C-t>', '<cmd>ToggleTerm powershell<cr>', options)
map('n', '<C-s>', '<cmd>w<cr>', options)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', options)
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', options)
map('n', '<leader>c', '<cmd>bd<cr>', options)

map('n', '<S-k>', '<cmd>lua vim.lsp.buf.hover()<cr>', options)

function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*/)")
end
print(script_path())


map('n', '<leader>Lc', '<cmd>edit C:\\Users\\Joshua\\AppData\\Local\\nvim\\init.lua<cr>', options)

local wk = require('which-key')
wk.register{
	['<C-t>'] = {
		function()
			local buf = vim.api.nvim_get_current_buf()
			local ft = vim.api.nvim_buf_get_option(buf, "filetype")
			if ft == "floaterm" then
				vim.cmd(':FloatermToggle<cr>')
			end
		end
	}
}
