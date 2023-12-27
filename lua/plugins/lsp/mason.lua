return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local servers = require("core.lsps")

    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    })
  end,
}
