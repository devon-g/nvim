local ok, null_ls = pcall(require, "null-ls")
if not ok then
	print("null-ls failed to load")
	return
end

local formatter = null_ls.builtins.formatting
local linter = null_ls.builtins.diagnostics

null_ls.setup({
	formatter.black,
	formatter.stylua,
	linter.flake8,
})
