local nvim_autopairs_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not nvim_autopairs_ok then
	return print("nvim-autopairs failed to load")
end

nvim_autopairs.setup()
