return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "folke/neodev.nvim"
  },
  config = function ()
    local lspconfig = require("lspconfig")
    local telescope_builtin = require("telescope.builtin")

    local on_attach = function (_, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      opts.desc = "Show LSP references"
      vim.keymap.set("n", "gR", telescope_builtin.lsp_references, opts)

      opts.desc = "Go to declaration"
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, opts)

      opts.desc = "Show LSP implementations"
      vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, opts)

      opts.desc = "Show LSP type definitions"
      vim.keymap.set("n", "gt", telescope_builtin.lsp_type_definitions, opts)

      opts.desc = "See available code actions"
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      vim.keymap.set("n", "<leader>D", telescope_builtin.diagnostics, opts)

      opts.desc = "Show line diagnostics"
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    end

    -- Use nvim-cmp to serve lsp suggestions
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure lua_ls to support nvim builtins
    local neodev = require("neodev")
    neodev.setup()

    -- Set up lsp servers from config file
    local servers = require("core.lsp.servers")
    for server, config in pairs(servers) do
      lspconfig[server].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	config = config,
      })
    end
  end,
}
