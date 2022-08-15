local M = {}

function M.setup()
  local lualine = require("lualine")

  lualine.setup({
    options = {
      component_separators = "",
      section_separators = "",
    },
  })
end

return M
