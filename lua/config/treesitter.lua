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

    -- Match end statement for a few languages (nvim-treesitter-endwise)
    endwise = {
      enable = true,
    },

    -- Match tags like html, xml, etc (nvim-ts-autotag)
    autotag = {
      enable = true,
    },
  }

  treesitter.setup(config)
end

return M
