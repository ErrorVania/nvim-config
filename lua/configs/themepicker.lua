local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local theme = require 'configs.theme'


local function list_themes()
	local themes = {}
	local rtp = vim.api.nvim_list_runtime_paths()
	for n = 1, #rtp do
		local files = vim.fn.split(vim.fn.globpath(rtp[n] .. '/colors', '*.vim'), '\n')
		for m = 1, #files do
			local themename = files[m]
			table.insert(themes, themename:match("^.+/(.+)%.[^.]+$"))
		end
	end

	return themes
end

-- our picker function: colors
local colors = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = 'Themes',
		finder = finders.new_table {
			results = list_themes()
		},
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				if selection ~= nil then
					if selection[1] ~= '' and selection[1] ~= nil then
						theme.save_theme(selection[1])
						theme.load_theme()
					end
				end
			end)
			return true
		end,
	}):find()
end

function M.run()
	colors(require('telescope.themes').get_dropdown {
		previewer = false,
		prompt_prefix = ' ',
		prompt_title = 'Themes'
	})
end

return M
