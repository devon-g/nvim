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
      highlight = { use_nvim_cmp_as_default = true, },
      accept = { auto_brackets = { enabled = true } },
      trigger = { signature_help = { enabled = true } },
    },
  }
}
