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
end

return M
