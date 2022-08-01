local ok, nvim_dev_icons = pcall(require, 'nvim-web-devicons')
if not ok then
  print('nvim-web-devicons failed to import')
  return
end

nvim_dev_icons.setup({})
