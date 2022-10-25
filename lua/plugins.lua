-- bootstrap packer - requires git
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
	   fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	   vim.cmd [[packadd packer.nvim]]
	   return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

require('packer').init{
	display = {
		open_fn = function()
			return require('packer.util').float{ border = 'rounded' }
		end
	}
}

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
-- Themes
	use 'Mofiqul/dracula.nvim'
	use 'joshdick/onedark.vim'
	use 'folke/tokyonight.nvim'
	use 'catppuccin/nvim'
-- The very important stuff
	use { 'lewis6991/impatient.nvim', config = function() require('impatient') end }
	use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons', config = function() require('bufferline').setup{
		options = {
			offsets = {
				{
					filetype = 'NvimTree',
					text = function()
						return 'Explorer'
					end,
					highlight = 'Directory',
					text_align = 'center'
				}, {
					filetype = 'undotree',
					text = function()
						return 'UndoTree'
					end,
					text_align = 'center'
				}
			}
		}

	} end }
	use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons', config = function() require('lualine').setup{ options = { disabled_filetypes = { 'alpha' }, globalstatus = true } } end }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' }
	use { "nvim-telescope/telescope-file-browser.nvim", config = function() require('telescope').load_extension 'file_browser' end }
	use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
	use { 'goolord/alpha-nvim', config = function () require'alpha'.setup(require'alpha.themes.dashboard'.config) end }
	use { 'folke/which-key.nvim', config = function() require('which-key').setup{ window = { border = 'single' } } end }
-- Non-LSP Stuff
	use 'p00f/nvim-ts-rainbow'
	use { 'nvim-treesitter/nvim-treesitter', config = function()
		require('nvim-treesitter.configs').setup{
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false
			},
			rainbow = {
				enable = true,
				extended_mode = true
			}
		}
		end,
		run = function() require('nvim-treesitter.install').update({ with_sync = true}) end
	}
	use { 'nvim-tree/nvim-tree.lua', requires = 'nvim-tree/nvim-web-devicons', config = function() require('nvim-tree').setup() end }
	use { 'numToStr/Comment.nvim', config = function() require('Comment').setup() end }
	use { 'akinsho/toggleterm.nvim', tag = '*', config = function() require('toggleterm').setup{ direction = 'float' } end }

-- Everything else
	use { 'williamboman/mason.nvim', config = function() require('mason').setup() end }
	use 'neovim/nvim-lspconfig'
	use { 'williamboman/mason-lspconfig.nvim', config = function() require('mason-lspconfig').setup() end }

	use 'jackguo380/vim-lsp-cxx-highlight'
	use { 'folke/trouble.nvim', config = function() require('trouble').setup() end }
	use { 'lukas-reineke/indent-blankline.nvim', config = function() require('indent_blankline').setup{
		show_end_of_line = true,
		space_char_blankline = ' '
	} end }

	-- i have no idea what im doing from this point on
	use { 'hrsh7th/nvim-cmp', config = function()
		local cmp = require('cmp')
		cmp.setup{
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end
			},
			mapping = cmp.mapping.preset.insert(
				{
					['<C-Space>'] = cmp.mapping.complete(),
					['<cr>'] = cmp.mapping.confirm({ select = true})
				}
			),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered()
			},
			sources = cmp.config.sources({{ name = "nvim_lsp" }, { name = "luasnip" }}, {{ name = "buffer" }})
		}
	end}

	use { 'windwp/nvim-autopairs', config = function() require('nvim-autopairs').setup{} end }

	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use { 'ray-x/lsp_signature.nvim', config = function() require('lsp_signature').setup{} end }
	use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
	use 'mbbill/undotree'
	use { 'ahmedkhalf/project.nvim', config = function()
		require('project_nvim').setup{
			patterns = {
				'.git', 'Makefile', 'CMakeLists.txt'
			},
			show_hidden = false
		}
		require('telescope').load_extension('projects')
	end }


	if packer_bootstrap then
	   require('packer').sync()
	end
end )

function _lazygit_toggle()
	local Terminal  = require('toggleterm.terminal').Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
	lazygit:toggle()
end

local cmp = require("cmp")
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

cmp.event:on(
	'confirm_done',
	require("nvim-autopairs.completion.cmp").on_confirm_done()
)


