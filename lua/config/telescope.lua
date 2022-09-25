local M = {}

function M.setup()
  local telescope = require("telescope")

  telescope.setup()
  telescope.load_extension("fzf")
  -- telescope.load_extension("project") -- telescope-project.nvim
  -- telescope.load_extension("repo")
  -- telescope.load_extension("file_browser")
  -- telescope.load_extension("projects") -- project.nvim
end

return M
