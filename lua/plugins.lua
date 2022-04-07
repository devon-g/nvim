-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
	return	-- Not loaded due to error
end

-- Bootstrapping for any machine I move this config to
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{
		pattern = "plugins.lua",
	command = "source <afile> | PackerSync"
	}
)
	
return packer.startup({
	function()
		use { "wbthomason/packer.nvim" }

		-- Color schemes
		use { "ellisonleao/gruvbox.nvim" }

		-- Syntax highlighting
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate"
		}

		-- Automatically set up configuration after cloning packer.nvim
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	
	-- Configuration of packer goes in this config table
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = 'single' })
			end
		}
	}
})
