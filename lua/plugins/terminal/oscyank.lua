return {
	"ojroques/vim-oscyank",
	event = "VeryLazy",
	config = function(_, opts)
		vim.keymap.set("n", "Y", "<Plug>OSCYankOperator")
		vim.keymap.set("n", "YY", "<leader>Y_", { remap = true })
		vim.keymap.set("v", "Y", "<Plug>OSCYankVisual")
	end,
}
