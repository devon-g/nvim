local opts = { noremap = true, silent = true }

-- Center search results
vim.keymap.set("n", "n", "nzz", opts)
vim.keymap.set("n", "N", "Nzz", opts)

-- Better indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Switch buffer
vim.keymap.set("n", "<S-h>", ":bp<CR>", opts)
vim.keymap.set("n", "<S-l>", ":bn<CR>", opts)

-- Cancel search highlight with ESC
vim.keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

-- Move selected line / block of text in visual mode
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", opts)

-- Resizing panes
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", opts)
