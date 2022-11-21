local M = {}

function M.bufferline_config()
	local ok, bufferline = pcall(require, 'bufferline')
	if not ok then
		return
	end

	bufferline.setup {
		options = {
			offsets = {
        		{
					filetype = 'NvimTree',
					text = "Files",
					highlight = 'Directory',
					text_align = 'center'
	       	    },
       	    	{
					filetype = 'undotree',
					text = "UndoTree",
					text_align = 'center'
				},
				{
					filetype = 'toggleterm',
					text = 'Terminal',
					text_align = 'center'
				}
     	   },
	        diagnostics = 'nvim_lsp',
   		    diagnostics_indicator = function(count, level)
	        	local icon = level:match("error") and " " or ""
    	    	return " " .. icon .. ' ' .. count
	    	end
    	}
	}
end

function M.setup(use)
	use {
		'akinsho/bufferline.nvim',
		tag = "v3.*",
		requires = 'kyazdani42/nvim-web-devicons',
		config = M.bufferline_config,
		event = 'User IsEditing'
	}
end


return M
