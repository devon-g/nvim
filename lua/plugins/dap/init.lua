return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "jay-babu/mason-nvim-dap.nvim",
      "williamboman/mason.nvim",
    },
    config = function ()
      local adapters = require("plugins.dap.adapters")
      local configurations = require("plugins.dap.configs")

      local dap = require("dap")
      local mason = require("mason")
      local mason_dap = require("mason-nvim-dap")
      local dapui = require("dapui")

      adapters.setup(dap)
      configurations.setup(dap)
      mason.setup()
      mason_dap.setup({
	ensure_installed = { "debugpy", "codelldb" },
	automatic_installation = true,
      })
      dapui.setup()

      -- Automatically open dapui when debugging starts and close when it ends
      dap.listeners.after.event_initialized["dapui_config"] = function ()
	dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function ()
	dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function ()
	dapui.close()
      end

      vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
      vim.keymap.set("n", "<leader>dc", dap.continue)
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
      vim.keymap.set("n", "<leader>dn", dap.step_over)
      vim.keymap.set("n", "<leader>di", dap.step_into)
      vim.keymap.set("n", "<leader>do", dap.step_out)
    end
  }
}
