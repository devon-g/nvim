require("core.options")
require("core.keymaps")
require("core.autocmd")

vim.pack.add({
  "https://github.com/ellisonleao/gruvbox.nvim",
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
})

-- Colorscheme
vim.api.nvim_command("colorscheme gruvbox")

-- LSP
vim.lsp.enable({
  "rust_analyzer", -- Use rustup provided analyzer instead of mason
  "lua_ls"
})

-- Autopairs
require("nvim-autopairs").setup({
  check_ts = true,
})

-- FZF
local fzf_lua = require("fzf-lua")
fzf_lua.setup({ "ivy", "hide" })

vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Fuzzy find files" })
vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep,
  { desc = "Fuzzy find string" })

-- Harpoon2
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-d>",
  function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>k", function() harpoon:list():prev() end)
vim.keymap.set("n", "<leader>j", function() harpoon:list():next() end)
