local ok, jdtls = pcall(require, 'jdtls')
local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not (ok and cmp_ok) then
  print('jdtls or nvim-cmp-lsp failed to import')
  return
end
