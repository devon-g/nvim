local hooks = function(ev)
  -- Use available |event-data|
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "blink.cmp" and (kind == "install" or kind == "update") then
    vim.notify("Building blink.cmp", vim.log.levels.INFO)
    local obj = vim.system({ "cargo", "build", "--release" },
      { cwd = ev.data.path }):wait()
    if obj.code == 0 then
      vim.notify("Building blink.cmp done", vim.log.levels.INFO)
    else
      vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
    end
  end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })

vim.pack.add({
  -- Theme
  "https://github.com/ellisonleao/gruvbox.nvim",
  "https://github.com/miikanissi/modus-themes.nvim",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/saghen/blink.cmp",

  -- Syntax
  "https://github.com/windwp/nvim-autopairs",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },

  -- File and text finding
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/stevearc/oil.nvim",
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2"
  },

  -- Dependencies
  "https://github.com/nvim-lua/plenary.nvim", -- Needed by harpoon
})

-- Theme
vim.api.nvim_command("colorscheme modus")

-- LSP
require("mason").setup()
require("blink-cmp").setup({
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

-- File and text finding
require("Oil").setup()

local fzf_lua = require("fzf-lua")
fzf_lua.setup({ "ivy", "hide" })

local harpoon = require("harpoon")
harpoon:setup()

-- Syntax
require("nvim-autopairs").setup({
  check_ts = true,
})

require("core.options")
require("core.keymaps")
require("core.autocmd")
