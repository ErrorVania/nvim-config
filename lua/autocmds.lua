local function check_git_repo()
	local f = vim.fs.find('.git', { type = 'directory' })
	if f ~= {} then
		vim.api.nvim_exec_autocmds('User', { pattern = 'InGitRepo' })
		return true
	end
end

local function is_tmux_sess()
	if os.getenv('TMUX') then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsTmuxSession' })
		return true
	end
end

local function is_editing()
	if vim.fn.argc() > 0 or vim.o.insertmode or vim.o.modifiable then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsEditing' })
		return true
	end
end

local autocommands = {
	{
		'FileType',
		{
			pattern = { 'help', 'checkhealth', 'OverseerList', 'ImportManager' },
			command = [[nnoremap <buffer><silent> q :close<CR>]]
		}
	},
	{
		'FileType',
		{
			pattern = { 'alpha' },
			command = [[nnoremap <buffer><silent> q :quit<CR>]]
		}
	},
	{
		{ 'VimEnter', 'DirChanged' },
		{ callback = function() vim.schedule(check_git_repo) end }
	},
	{
		{ 'VimEnter' },
		{ callback = function() vim.schedule(is_tmux_sess) end }
	},
	{
		{ 'VimEnter', 'FileType' },
		{
			callback = function()
				local blacklist = {
					'mason',
					'packer'
				}
				for _, value in ipairs(blacklist) do
					if vim.bo.filetype == value then
						return
					end
				end
				vim.schedule(is_editing)
			end,
			pattern = '*'
		}
	}
}

return autocommands
