import('nvim-treesitter.configs', function(tsc)
	tsc.setup {
		auto_install = true,
		-- ensure_installed = { 'lua'},
		-- sync_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false
		},
		rainbow = {
			enable = true,
			extended_mode = true
		},
		autotag = {
			enable = true
		}
	}
	vim.opt.foldmethod = "expr"
	vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	vim.opt.foldlevel = 20

end)
