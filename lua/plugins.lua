-- Use a protected call so we don't error out on first use
local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
	return print("Packer not loaded properly")
end

local p_util_ok, p_util = pcall(require, "packer.util")
if not p_util_ok then
	return print("Packer Utils not loaded properly")
end

-- Auto source plugins on file save
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{
		pattern = "plugins.lua",
		command = "source <afile> | PackerSync"
	}
)

return packer.startup({
	-- Install plugins
	function(use)
		use { "wbthomason/packer.nvim" }

		-- Color schemes
		use { "ellisonleao/gruvbox.nvim" }

		-- Syntax highlighting
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate"
		}

		-- Language Servers
		use { "neovim/nvim-lspconfig" }
		use { "mfussenegger/nvim-jdtls" }
		use { "lervag/vimtex" }

		-- Completion
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lua",
				"onsails/lspkind-nvim"
			}
		}

		use { "windwp/nvim-autopairs" }

		-- Snippet plugins
		use { "L3MON4D3/LuaSnip" }
		use { "saadparwaiz1/cmp_luasnip" }
	end,
	-- Use floating window
	config = {
		display = {
			open_fn = p_util.float
		}
	}
})
