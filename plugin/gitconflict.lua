local ok, gitconflict = pcall(require, 'git-conflict')
if not ok then
	return
end

gitconflict.setup()
