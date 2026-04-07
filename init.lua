vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/miikanissi/modus-themes.nvim",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/windwp/nvim-autopairs",
  "https://github.com/ibhagwan/fzf-lua",
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2"
  },
  "https://github.com/nvim-lua/plenary.nvim", -- Needed by harpoon
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  "https://github.com/mason-org/mason.nvim",
})

-- Colorscheme
vim.api.nvim_command("colorscheme modus")

-- LSP
vim.lsp.enable({
  "lua_ls",
  "gopls",
})

-- File browsing
require("Oil").setup()

-- Tooling
require("mason").setup()

require("nvim-autopairs").setup({
  check_ts = true,
})

local fzf_lua = require("fzf-lua")
fzf_lua.setup({ "ivy", "hide" })

local harpoon = require("harpoon")
harpoon:setup()

require("core.options")
require("core.keymaps")
require("core.autocmd")
