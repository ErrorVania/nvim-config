return {
	'nvim-treesitter/nvim-treesitter',
	dependencies = {
		{ 'HiPhish/nvim-ts-rainbow2', after = 'nvim-treesitter' },
		{ 'windwp/nvim-ts-autotag',   after = 'nvim-treesitter' }
	},
	build = function()
		import('nvim-treesitter.install', function(t)
			t.update {}
		end)
	end,
	config = function()
		require('nvim-treesitter.configs').setup{
			auto_install = true,
			ensure_installed = { 'lua', 'vim' },
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
	end,
}
