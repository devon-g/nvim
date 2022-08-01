local dap = require("dap")
local dap_utils = require("dap.utils")
local dapui = require("dapui")
local nvim_dap_virtual_text = require("nvim-dap-virtual-text")

-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<F5>", '<cmd>lua require("dap").continue()<CR>', opts)
vim.keymap.set("n", "<F10>", '<cmd>lua require("dap").step_over()<CR>', opts)
vim.keymap.set("n", "<F11>", '<cmd>lua require("dap").step_into()<CR>', opts)
vim.keymap.set("n", "<F12>", '<cmd>lua require("dap").step_out()<CR>', opts)
vim.keymap.set("n", "<Space>b", '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
vim.keymap.set(
	"n",
	"<Space>B",
	'<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
	opts
)
vim.keymap.set(
	"n",
	"<Space>lp",
	'<cmd>lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	opts
)
vim.keymap.set("n", "<Space>ro", '<cmd>lua require("dap").repl.open()<CR>', opts)
vim.keymap.set("n", "<Space>rl", '<cmd>lua require("dap").run_last()<CR>', opts)

-- Initialize dapui
dapui.setup()

-- Initialize dap virtual text
nvim_dap_virtual_text.setup({ commented = true })

-- Open and close UI based on events
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end

-- Setup dap adapters and configurations
-- Adapters
dap.adapters.codelldb = {

	type = "server",
	port = "${port}",
	executable = {
		command = "/home/devon/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}

-- Configurations
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		pid = dap_utils.pick_process,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp
