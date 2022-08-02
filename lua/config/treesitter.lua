local M = {}


function M.setup()
  local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  local config = {
    ensure_installed = "all",
    -- Syntax highlighting
    highlight = { enable = true },
  }

  treesitter.setup(config)
end

return M
