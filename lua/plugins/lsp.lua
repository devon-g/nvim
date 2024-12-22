return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Mason plugins must be set up before neovim's lspconfig
    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls" },
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- SET UP LSP SERVERS
    local lspconfig = require("lspconfig")
    mason_lspconfig.setup_handlers({
      -- Default handler
      function(server_name)
        lspconfig[server_name].setup({})
        capabilities = capabilities
      end,
      -- Specific handlers
      ["lua_ls"] = function() -- Requires special setup for nvim configs
        lspconfig.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        })
      end,
      ["jdtls"] = function()
        lspconfig.jdtls.setup({
          capabilities = capabilities,
          cmd = {
            "jdtls",
            "-configuration",
            tostring(vim.fn.getenv("HOME")) .. "/.cache/jdtls/config",
            "-data",
            tostring(vim.fn.getenv("HOME")) .. "/.cache/jdtls/workspace",
            "--jvm-arg=-javaagent:"
              .. require("mason-registry").get_package("jdtls"):get_install_path()
              .. "/lombok.jar",
          },
        })
      end,
    })
  end,
}
