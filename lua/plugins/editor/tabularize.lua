return {
	"godlygeek/tabular",
	cmd = { "Tabularize" },
	keys = {
		{ "<leader>fa=", ":Tabularize /=<CR>", mode = { "n", "v" }, desc = "Align around =" },
		{ "<leader>fa:", ":Tabularize /:<CR>", mode = { "n", "v" }, desc = "Align around :" },
		{ "<leader>fat", ":Tabularize /", mode = { "n", "v" }, desc = "Align around..." },
	},
}
