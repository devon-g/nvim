return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)
    vim.lsp.enable({
      "rust_analyzer", -- Use rustup provided analyzer instead of mason
    })
  end
}
