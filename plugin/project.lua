local ok, project = pcall(require, 'project_nvim')
if not ok then
	return
end

project.setup{
	patterns = {'.git', 'Makefile', 'CMakeLists.txt'},
    show_hidden = false
}

