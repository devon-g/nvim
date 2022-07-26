local dap_ok, dap = pcall(require, 'dap')
local dapui_ok, dapui = pcall(require, 'dapui')
local dap_utils_ok, dap_utils = pcall(require, 'dap.utils')
if not (dap_ok and dapui_ok and dap_utils_ok) then
  print('dap and/or dapui failed to load')
  return
end

-- Mappings
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<F5>', '<cmd>lua require("dap").continue()<CR>', opts)
vim.keymap.set('n', '<F10>', '<cmd>lua require("dap").step_over()<CR>', opts)
vim.keymap.set('n', '<F11>', '<cmd>lua require("dap").step_into()<CR>', opts)
vim.keymap.set('n', '<F12>', '<cmd>lua require("dap").step_out()<CR>', opts)
vim.keymap.set('n', '<Space>b', '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
vim.keymap.set('n', '<Space>B', '<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', opts)
vim.keymap.set('n', '<Space>lp', '<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', opts)
vim.keymap.set('n', '<Space>ro', '<cmd>lua require("dap").repl.open()<CR>', opts)
vim.keymap.set('n', '<Space>rl', '<cmd>lua require("dap").run_last()<CR>', opts)

-- Initialize dapui
dapui.setup()

-- Open and close UI based on events
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

-- Adapters
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

-- Configurations
dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
  {
    name = "Attach to process",
    type = 'lldb',
    request = 'attach',
    pid = dap_utils.pick_process,
    args = {}
  }
}

dap.configurations.c = dap.configurations.cpp
