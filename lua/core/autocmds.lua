local autocmd = vim.api.nvim_create_autocmd

autocmd("VimResized", {
	desc = "Automatically resize windows when the terminal is resized",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})
