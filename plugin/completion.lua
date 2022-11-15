local ok, cmp = pcall(require, 'cmp')
if not ok then
	return
end

cmp.setup {
	snippet = {
    	expand = function(args)
        	require("luasnip").lsp_expand(args.body)
        end
    },
	mapping = cmp.mapping.preset.insert{
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<cr>'] = cmp.mapping.confirm({select = true})
    },
    window = {
        completion = cmp.config.window.bordered{
        	scrolloff = 1,
        },
        documentation = cmp.config.window.bordered{
        }
    },
	sources = cmp.config.sources({
		{name = "nvim_lsp"}, {name = "luasnip"}
    }, {{name = "buffer"}}),
    formatting = {
		format = function(entry, vim_item)
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
	sources = {{name = 'buffer'}}
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})

cmp.event:on('confirm_done', require("nvim-autopairs.completion.cmp").on_confirm_done())
