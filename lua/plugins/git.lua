return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({"]c", bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({"[c", bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage git hunk" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset git hunk" })
        map("v", "<leader>hs",
          function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage git hunk" })
        map("v", "<leader>hr",
          function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset git hunk" })
        map("n", "<leader>hS", gitsigns.stage_buffer,
          { desc = "Stage git hunks in buffer" })
        map("n", "<leader>hu", gitsigns.undo_stage_hunk,
          { desc = "Undo stage git hunk" })
        map("n", "<leader>hR", gitsigns.reset_buffer,
          { desc = "Reset buffer hunks" })
        map("n", "<leader>hp", gitsigns.preview_hunk,
          { desc = "Preview git hunk" })
        map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end,
          { desc = "Toggle git blame float" })
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame,
          { desc = "Toggle current line git blame" })
        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Show git diff" })
        map("n", "<leader>hD", function() gitsigns.diffthis("~") end)
        map("n", "<leader>td", gitsigns.toggle_deleted,
          { desc = "Toggle deleted git hunks" })

        -- Text object
        map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },
}
