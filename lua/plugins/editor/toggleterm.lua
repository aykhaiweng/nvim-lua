return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {},
	keys = {
		{

			"<F5>",
			"<cmd>ToggleTerm<cr>",
			desc = "Toggle Term",
			mode = {"n", "t", "i", "v"}
		},
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)
	end,
}
