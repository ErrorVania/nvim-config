local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then
	return
end

nvimtree.setup{
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
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
		},
		icons = {
			git_placement = 'signcolumn',
			padding = ' ',
			glyphs = {
				git = {
					unstaged = '',
					staged = '',
					untracked = ''
				}
			}
		}
	},
	update_focused_file = {
		enable = true,
		update_root = true
	},
	git = {
		ignore = false
	}
}

local colorok, colors = pcall(require, 'catppuccin.palettes')
if colorok then
	colors = colors.get_palette()
	local hs = {
		NvimTreeGitDirty = { fg = colors.sky }
	}

	for hl, col in pairs(hs) do
		vim.api.nvim_set_hl(0, hl, col)
	end
end
