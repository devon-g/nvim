return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "folke/neodev.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    -- Mason plugins must be set up before neovim's lspconfig
    mason.setup()
    mason_lspconfig.setup({
      ensure_installed = { "lua_ls" },
    })

    -- SET UP LSP SERVERS
    local lspconfig = require("lspconfig")
    mason_lspconfig.setup_handlers({
      -- Default handler
      function(server_name)
        lspconfig[server_name].setup({})
      end,
      -- Specific handlers
      ["lua_ls"] = function() -- Requires special setup for nvim configs
        require("neodev").setup({})
        lspconfig.lua_ls.setup({
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
