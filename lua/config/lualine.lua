local M = {}

function M.setup()
  local navic = require("nvim-navic")

  require("lualine").setup({
    options = {
      disabled_filetypes = {},
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
    sections = {
      lualine_c = {
        { 'filename' },
        {
          navic.get_location,
          cond = navic.is_available,
        },
      },
    },
  })
end

return M
