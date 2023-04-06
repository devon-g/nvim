-- Manage diagnostic messages
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Goto previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Goto next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic list" })

-- Find and move between files
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
vim.keymap.set("n", "<leader>?", telescope_builtin.oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader><space>", telescope_builtin.buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>/", function ()
    telescope_builtin.current_buffer_fuzzy_find(telescope_themes.get_dropdown({
        previewer = false,
    }))
end,{ desc = "Fuzzy search in current buffer" })
vim.keymap.set("n", "<leader>sf", telescope_builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", telescope_builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", telescope_builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", telescope_builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", telescope_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
