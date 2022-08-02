local M = {}

function M.setup()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    return
  end

  local config = {
    direction = "float",
  }

  -- Configure toggleterm global settings
  toggleterm.setup(config)

  -- Custom terminal for lazygit
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    dir = "git_dir",
    float_opts = {
      border = "curved",
    },
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
  })

  -- Create global function to toggle the lazygit terminal
  -- Mapped to <leader>g in after/plugin/keymaps.lua
  function _lazygit_toggle()
    lazygit:toggle()
  end
end

return M
