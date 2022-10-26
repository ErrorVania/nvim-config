-- bootstrap packer - requires git
local bootstrap_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
		if fn.executable('git') ~= 1 then
			print 'could not find git executable, cannot bootstrap packer!'
			os.exit()
		end

        fn.system{
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        }
        vim.cmd[[packadd packer.nvim]]
        return true
    end
    return false
end

packer_bootstrapped = bootstrap_packer()

packer_ok, packer = pcall(require, 'packer')
if packer_ok then
	require('plugins')

	if not packer_bootstrapped and packer_ok then
		require('vim-opts')
		require("lspconfigs")
		require("keymaps")
	else
		packer.sync()
	end
end

