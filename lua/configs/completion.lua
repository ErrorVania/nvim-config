local M = {}

function M.configure_cmp()
	local ok, cmp = pcall(require, 'cmp')
	if not ok then
		return
	end

	-- vim.api.nvim_set_hl(0, "CmpFloat",
	-- 	{ fg = '#313244' }
	-- )

	cmp.setup {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end
		},
		mapping = cmp.mapping.preset.insert {
			['<C-Space>'] = cmp.mapping.complete(),
			['<cr>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Insert,
				select = true
			},
			['<tab>'] = cmp.mapping.select_next_item()
		},
		window = {
			completion = cmp.config.window.bordered {
				scrolloff = 1,
				border = 'single',
				-- winhighlight = 'FloatBorder:CmpFloat'
			},
			documentation = cmp.config.window.bordered {
				border = 'single',
				-- winhighlight = 'FloatBorder:CmpFloat'
			}
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, { name = "luasnip" }
		}, { { name = "buffer" } }),
		formatting = {
			fields = { 'kind', 'abbr', 'menu' },
			format = function(_, vim_item)
				local icons = {
					Keyword = '',
					Text = '',
					Snippet = '',
					Function = '',
					Class = '',
					Interface = '',
					Module = '',
					Struct = '',
					Enum = '',
					EnumMember = '',
					Variable = '',
					Method = '',
					Field = '',
					Property = '',
					Constructor = '',
					Reference = ''
				}

				for k, v in pairs(icons) do
					if vim_item.kind == k then
						vim_item.kind = v .. ' ' .. vim_item.kind
						break
					end
				end
				return vim_item
			end
		}
	}

	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = { { name = 'buffer' } }
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
	})
end

function M.setup_autopairs()
	local ok, ap = pcall(require, 'nvim-autopairs')
	if not ok then
		return
	end

	ap.setup {}

	local ok2, cmp = pcall(require, 'cmp')
	if not ok2 then
		return
	end

	cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
end

function M.setup(use)
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer' },
			{ 'hrsh7th/cmp-path' },
			{ 'hrsh7th/cmp-cmdline' },
			{ 'saadparwaiz1/cmp_luasnip' },
			{ 'L3MON4D3/LuaSnip' },
		},
		config = M.configure_cmp,
		--event = 'User IsEditing'
	}

	use {
		'windwp/nvim-autopairs',
		requires = 'hrsh7th/nvim-cmp',
		after = 'nvim-cmp',
		config = M.setup_autopairs
	}
end

return M
