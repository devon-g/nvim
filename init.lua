-- Theme
vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/miikanissi/modus-themes.nvim",
})
vim.api.nvim_command("colorscheme modus")

-- LSP
vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
})
require("mason").setup()

-- Auto Completion
vim.pack.add({
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp"
})
local cmp = require("blink.cmp")
cmp.build():wait(60000)
cmp.setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    list = { selection = { auto_insert = false } },
    documentation = { auto_show = true },
    ghost_text = { enabled = true },
  },
})

vim.lsp.enable({
  "lua_ls",
  "gopls",
})

-- File browsing
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup()

-- Fuzzy finding
vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })
local fzf_lua = require("fzf-lua")
fzf_lua.setup({ "ivy", "hide" })

-- Syntax
vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })
require("nvim-autopairs").setup({
  check_ts = true,
})

require("core.options")
require("core.keymaps")
require("core.autocmd")
