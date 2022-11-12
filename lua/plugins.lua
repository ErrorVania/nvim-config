packer.init {
	git = {
		clone_timeout = 300
	},
    display = {
        open_fn = function()
            return require('packer.util').float {border = 'rounded'}
        end
    }
}

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- Themes
    use 'Mofiqul/dracula.nvim'
    use 'joshdick/onedark.vim'
    use 'folke/tokyonight.nvim'
    use 'catppuccin/nvim'
    -- The very important stuff
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    offsets = {
                        {
                            filetype = 'NvimTree',
                            text = "Explorer",
                            highlight = 'Directory',
                            text_align = 'center'
                        }, {
                            filetype = 'undotree',
                            text = "UndoTree",
                            text_align = 'center'
                        }
                    },
                	diagnostics = 'nvim_lsp'
                }
            }
        end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('lualine').setup {
                options = {disabled_filetypes = {'alpha'}, globalstatus = true}
            }
        end
    }
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
        	'nvim-lua/plenary.nvim',
        	'nvim-telescope/telescope-file-browser.nvim',
			'ahmedkhalf/project.nvim'
		},
        config = function()
			local telescope = require('telescope')
			require('project_nvim').setup {
               	patterns = {'.git', 'Makefile', 'CMakeLists.txt'},
               	show_hidden = false
            }
			telescope.load_extension('projects')
			telescope.load_extension('file_browser')
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function() require('gitsigns').setup() end
    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require'alpha'.setup(require'alpha.themes.dashboard'.config)
        end
    }
    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {window = {border = 'single'}}
        end
    }
    -- Non-LSP Stuff
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {'p00f/nvim-ts-rainbow', after= 'nvim-treesitter'},
        config = function()
            require('nvim-treesitter.configs').setup {
                auto_install = true,
                sync_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                rainbow = {enable = true, extended_mode = true}
            }
        end,
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
        	require('nvim-tree').setup{
				sort_by = 'case_sensitive',
				hijack_cursor = true,
				view = {
					adaptive_size = true,
					mappings = {
						list = {
							{ key = { "<CR>", "o", "<2-LeftMouse>", "l" }, action = "edit" }
						}
					}
				},
				diagnostics = {
					enable = true
				},
				filters = {
					dotfiles = true,
					custom = {
						'^.git$'
					}
				},
				renderer = {
					highlight_opened_files = 'name',
					indent_width = 4,
					indent_markers = {
						enable = true,
					}
				},
				update_focused_file = {
					enable = true
				}
			}
    	end
    }
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use {
        'akinsho/toggleterm.nvim',
        tag = '*',
        config = function()
            require('toggleterm').setup {direction = 'float'}
        end
    }

    -- Everything else
    use {
        'williamboman/mason.nvim',
        config = function() require('mason').setup() end
    }
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/mason-lspconfig.nvim',
        config = function() require('mason-lspconfig').setup() end
    }

    use 'jackguo380/vim-lsp-cxx-highlight'
    use {
        'folke/trouble.nvim',
        config = function() require('trouble').setup() end
    }
    use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup {
                show_end_of_line = true,
                space_char_blankline = ' '
            }
        end
    }

    -- i have no idea what im doing from this point on
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-path', after = 'nvim-cmp'},
            {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
            {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'},
            {'L3MON4D3/LuaSnip', after = 'nvim-cmp'},
			{'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup{}]]}
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<cr>'] = cmp.mapping.confirm({select = true})
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                sources = cmp.config.sources({
                    {name = "nvim_lsp"}, {name = "luasnip"}
                }, {{name = "buffer"}})
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
       	end
    }

    use {
        'ray-x/lsp_signature.nvim',
        config = [[require('lsp_signature').setup{}]]
    }
    use {'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix'}
    use 'mbbill/undotree'
    use {'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim', config = [[require('todo-comments').setup{}]]}
    use {'akinsho/git-conflict.nvim', tag = '*', config = [[require('git-conflict').setup()]]}
    use 'stevearc/dressing.nvim'
    use 'christoomey/vim-tmux-navigator'
end)


