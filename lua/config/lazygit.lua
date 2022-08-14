local M = {}

function M.setup()
  -- Default options
  -- vim.g.lazygit_floating_window_winblend = 0 " transparency of floating window
  -- vim.g.lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
  -- vim.g.lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
  -- vim.g.lazygit_floating_window_use_plenary = 0 " use plenary.nvim to manage floating window if available
  -- vim.g.lazygit_use_neovim_remote = 1 " fallback to 0 if neovim-remote is not installed
  vim.g.lazygit_floating_window_scaling_factor = 1.0

  -- Use nvim-remote
  if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") then
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  end
end

return M
