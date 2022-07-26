local nvim_dap_virtual_text_ok, nvim_dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not nvim_dap_virtual_text_ok then
  print('nvim-dap-virtual-text failed to load.')
  return
end

nvim_dap_virtual_text.setup({
  commented = true
})
