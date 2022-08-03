local M = {}

function M.setup()
  local status_ok, nvim_tree = pcall(require, "nvim-tree")
  if not status_ok then
    return
  end

  local config = {
    disable_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    view = {
      adaptive_size = true,
    },
    renderer = {
      highlight_git = true,
      icons = {
        glyphs = {
          git = {
            unstaged = "",
            staged = "S",
            untracked = "U",
          },
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    diagnostics = {
      enable = true,
    },
  }

  nvim_tree.setup(config)
end

return M
