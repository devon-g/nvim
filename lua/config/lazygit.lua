local M = {}

function M.setup()
  -- Use plenary
  vim.g.lazygit_floating_window_use_plenary = 1

  -- Use nvim-remote
  if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") then
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  end
end

return M
