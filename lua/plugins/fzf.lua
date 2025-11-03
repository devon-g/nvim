return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      { "ivy", "hide" }, -- profile selection
    },
    config = function(_, opts)
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup(opts)

      vim.keymap.set("n", "<leader>ff", fzf_lua.files,
        { desc = "Fuzzy find files" })
      vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep,
        { desc = "Fuzzy find string" })
    end,
  },
}
