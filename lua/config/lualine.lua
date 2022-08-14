local M = {}

function M.setup()
  require("lualine").setup({
    options = {
      disabled_filetypes = {},
      component_separators = "",
      section_separators = "",
      globalstatus = true,
    },
  })
end

return M
