return {
	"NStefan002/screenkey.nvim",
	lazy = false,
	version = "*", -- or branch = "main" for latest
	opts = {
		win_opts = {
			row = 1,
			col = vim.o.columns - 1,
			width = 40,
			height = 1,
			border = "rounded",
		},
		show_leader = true,
		group_mappings = true,
	},
	keys = {
		{ "<leader>sk", "<cmd>Screenkey<cr>", desc = "Toggle Screenkey" },
	},
}
