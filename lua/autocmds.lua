local M = {}

M.check_git_repo = function()
	local f = vim.fs.find('.git', { type = 'directory' })
	if f ~= {} then
		vim.api.nvim_exec_autocmds('User', { pattern = 'InGitRepo' })
		return true
	end
end

M.is_tmux_sess = function()
	if os.getenv('TMUX') then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsTmuxSession' })
		return true
	end
end

M.is_editing = function()
	if vim.fn.argc() > 0 or vim.o.insertmode or vim.o.modifiable then
		vim.api.nvim_exec_autocmds('User', { pattern = 'IsEditing' })
		return true
	end
end

M.define_autocmds = function(t)
	for _, cmd in pairs(t) do
		vim.api.nvim_create_autocmd(cmd[1],cmd[2])
	end
end

return M
