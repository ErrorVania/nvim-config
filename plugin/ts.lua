local ok, treesitter = pcall(require, 'nvim-treesitter')
if not ok then
	return
end

require('nvim-treesitter.configs').setup{
	auto_install = true,
    sync_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    rainbow = {
    	enable = true,
    	extended_mode = true
    }
}
