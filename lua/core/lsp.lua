-- Default config
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Enable servers configured in lsp/<server_name>.lua
vim.lsp.enable({
  "clangd",
  "css_lsp",
  "lua_ls",
  "superhtml",
  "zls",
  "rust_analyzer",
  "basedpyright",
})
