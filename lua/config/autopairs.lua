local M = {}

function M.setup()
  local nvim_autopairs = require("nvim-autopairs")

  nvim_autopairs.setup({
    check_ts = true,
  })
  nvim_autopairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
end

return M
