local M = {}

local servers = {
  bashls = {}, -- Bash
  clangd = {}, -- C/C++
  cmake = {}, -- CMake
  hls = {}, -- Haskell
  html = {}, -- HTML
  jsonls = {}, -- JSON
  lemminx = {}, -- XML
  pyright = {}, -- Python
  sumneko_lua = { -- Lua
    -- settings = {
    --   Lua = {
    --     runtime = {
    --       -- Tell the language server which version of lua you are using
    --       version = "LuaJIT",
    --       -- Setup your lua path
    --       path = vim.split(package.path, ";"),
    --     },
    --     diagnostics = {
    --       -- Get the language server to recognize the `vim` global
    --       globals = { "vim" },
    --     },
    --     workspace = {
    --       -- Make the server aware of Neovim runtime files
    --       library = vim.api.nvim_get_runtime_file("", true),
    --     },
    --     telemetry = {
    --       enable = false,
    --     },
    --   },
    -- },
  },
  yamlls = {}, -- YAML
}

-- local status_ok, lsp_signature = pcall(require, "lsp_signature")
-- if not status_ok then
--   return
-- end
--
-- lsp_signature.setup({
--   bind = true,
-- })

local function on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr
  -- See `:help formatexpr` for more information
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
if PLUGINS.nvim_cmp.enabled then
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp
end

local opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

function M.setup()
  require("config.lsp.installer").setup(servers, opts)
end

return M
