local lsp_colors_ok, lsp_colors = pcall(require, 'lsp-colors')
if not lsp_colors_ok then
  print('lsp-colors failed to import')
  return
end

lsp_colors.setup({})
