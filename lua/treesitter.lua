local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

ts_configs.setup({
	-- Ensure that all maintained parsers are installed
	ensure_installed = "maintained",

	-- Syntax highlighting module (settings configured here)
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true
	}
})
