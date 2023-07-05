return {
  setup = function (dap)
    dap.configurations.python = {
      {
	type = "debugpy",
	request = "launch",
	name = "Launch",
	program = "${file}",
	pythonPath = function ()
	  return "/usr/bin/python3"
	end,
      },
    }

    dap.configurations.cpp = {
      {
	type = "codelldb",
	request = "launch",
	name = "Launch",
	program = function ()
	  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
	end,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp
  end
}
