local ok, term = pcall(require, 'toggleterm')
if not ok then
	return
end

-- require("winbar").setup {
-- 	enabled = true
-- }

term.setup {
	size = function(t)
		if t.direction == "horizontal" then
			return 15
		elseif t.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<C-t>]],
	winbar = {
		enabled = true,
		name_formatter = function(t)
			return t.name
		end
	}
}

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://*term* lua set_terminal_keymaps()')
