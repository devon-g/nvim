return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")

      telescope.setup({})
      telescope.load_extension("fzf")

      -- Setup keymaps
      vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Fuzzy find files in cwd" })
      vim.keymap.set("n", "<leader>fr", telescope_builtin.oldfiles, { desc = "Fuzzy find recent files" })
      vim.keymap.set("n", "<leader>fs", telescope_builtin.live_grep, { desc = "Find string in cwd" })
      vim.keymap.set("n", "<leader>fc", telescope_builtin.grep_string, { desc = "Find string under cursor in cwd" })
    end
  },
}
