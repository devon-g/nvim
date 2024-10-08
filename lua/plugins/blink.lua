return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
    },
    version = "v0.*",
    opts = {
      keymap = {
        select_prev = { "<C-p>" },
        select_next = { "<C-n>" },
      },
      highlight = { use_nvim_cmp_as_default = true, },
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
    },
  }
}
