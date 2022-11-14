local mason_ok, mason = pcall(require, 'mason')
local masonlsp_ok, masonlsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not masonlsp_ok then
	return
end

mason.setup{
	ui = {
		border = 'single'
	}
}
masonlsp.setup()

