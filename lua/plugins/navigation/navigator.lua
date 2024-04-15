return {
	{
		"numToStr/Navigator.nvim",
		lazy = true,
		cmd = {
			"NavigatorLeft",
			"NavigatorRight",
			"NavigatorUp",
			"NavigatorDown",
			"Navigator",
		},
		keys = function()
			return {
				{ "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n" }, desc = ":NavigatorLeft" },
				{ "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n" }, desc = ":NavigatorRight" },
				{ "<C-k>", "<CMD>NavigatorUp<CR>", mode = { "n" }, desc = ":NavigatorUp" },
				{ "<C-j>", "<CMD>NavigatorDown<CR>", mode = { "n" }, desc = ":NavigatorDown" },
				{ "<C-h>", "<C-\\><C-n><CMD>NavigatorLeft<CR>", mode = { "t" }, desc = ":NavigatorLeft" },
				{ "<C-l>", "<C-\\><C-n><CMD>NavigatorRight<CR>", mode = { "t" }, desc = ":NavigatorRight" },
				{ "<C-k>", "<C-\\><C-n><CMD>NavigatorUp<CR>", mode = { "t" }, desc = ":NavigatorUp" },
				{ "<C-j>", "<C-\\><C-n><CMD>NavigatorDown<CR>", mode = { "t" }, desc = ":NavigatorDown" },
			}
		end,
		config = function()
			require("Navigator").setup()
		end,
	},
}
