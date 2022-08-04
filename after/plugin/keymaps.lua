local opts = { noremap = true, silent = true }

-- Center search results
vim.api.nvim_set_keymap("n", "n", "nzz", opts)
vim.api.nvim_set_keymap("n", "N", "Nzz", opts)

-- Better indent
vim.api.nvim_set_keymap("v", "<", "<gv", opts)
vim.api.nvim_set_keymap("v", ">", ">gv", opts)

-- Cancel search highlight with ESC
vim.api.nvim_set_keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Move selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Resizing panes
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize +1<CR>", opts)
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize -1<CR>", opts)
vim.api.nvim_set_keymap("n", "<Up>", ":resize -1<CR>", opts)
vim.api.nvim_set_keymap("n", "<Down>", ":resize +1<CR>", opts)

-- Open lazygit popup terminal
vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", opts)

-- Open fuzzy finder
vim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>FzfLua files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>FzfLua git_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", opts)

-- Open nvim-tree
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeRefresh | NvimTreeToggle<CR>", opts)
