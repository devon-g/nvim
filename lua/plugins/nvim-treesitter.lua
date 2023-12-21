return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      highlight = {
	enable = true,
      },
      indent = {
	enable = true,
      },
      ensure_installed = {
	"python",
	"lua",
	"cpp",
	"markdown",
      },
      incremental_selection = {
	enable = true,
	keymaps = {
	  init_selection = "<C-space>",
	  node_incremental = "<C-space>",
	  scope_incremental = false,
	  node_decremental = "<bs>"
	},
      },
    },
  }
}
