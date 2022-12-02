local M = {}

function M.setup()
  local null_ls = require("null-ls")
  local f = null_ls.builtins.formatting
  local d = null_ls.builtins.diagnostics
  null_ls.setup({
    sources = {
      -- C++
      f.clang_format,
      d.clang_check,

      -- CMake
      f.cmake_format,
      d.cmake_lint,
    }
  })
end

return M
