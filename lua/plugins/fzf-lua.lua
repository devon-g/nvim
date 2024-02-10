return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			{ "junegunn/fzf", build = "./install --bin" },
		},
		opts = {},
		config = function()
			local fzf_lua = require("fzf-lua")

			vim.keymap.set("n", "<leader>ff", fzf_lua.files, { desc = "Fuzzy find files" })
			vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep, { desc = "Fuzzy find string" })
		end,
	},
}
