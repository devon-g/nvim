local mason_ok, mason = pcall(require, 'mason')
local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not (mason_ok and mason_lspconfig_ok) then
  print('mason or mason-lsp failed to import')
  return
end

mason.setup()
mason_lspconfig.setup()
