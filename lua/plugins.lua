-- Use a protected call so we don't error out on first use
local ok, packer = pcall(require, "packer")
if not ok then
	return	-- Not loaded due to error
end
	
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

		-- Language server
		use {
			"neovim/nvim-lspconfig",
		}

		-- Completion
		use {
			"hrsh7th/nvim-cmp",
			--"hrsh7th/cmp-nvim-lsp",
			--"hrsh7th/cmp-buffer",
			--"hrsh7th/cmp-path",
			--"hrsh7th/cmp-cmdline",
			--"hrsh7th/cmp-nvim-lua",
			--"onsails/lspkind-nvim"
		}

		-- Snippet plugins
		use {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip"
		}
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
