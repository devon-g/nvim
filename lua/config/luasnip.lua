local M = {}

function M.setup()
  require("luasnip").config.set_config({
    updateevents = "TextChanged,TextChangedI",
  })
  require("luasnip/loaders/from_vscode").load()
end

return M
