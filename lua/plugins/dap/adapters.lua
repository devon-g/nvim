return {
  setup = function (dap)
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
	command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/codelldb",
	args = { "--port", "${port}" },
      },
    }

    dap.adapters.debugpy = {
      type = "executable",
      command = os.getenv("HOME") .. "/.local/share/nvim/mason/bin/debugpy-adapter",
    }
  end
}
