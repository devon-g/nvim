local cmake_ok, cmake = pcall(require, 'cmake')
if not cmake_ok then
  print('cmake failed to load.')
  return
end

cmake.setup({
  dap_configuration = {
    type = 'lldb',
    request = 'launch',
    stoponEntry = false,
    runInTerminal = false
  }
})
