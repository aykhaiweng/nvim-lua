return {
	{
		"numToStr/Navigator.nvim",
		lazy = true,
		keys = function()
			return {
				{ "<C-h>", "<CMD>NavigatorLeft<CR>", { "n" }, desc = ":NavigatorLeft" },
				{ "<C-l>", "<CMD>NavigatorRight<CR>", { "n" }, desc = ":NavigatorRight" },
				{ "<C-k>", "<CMD>NavigatorUp<CR>", { "n" }, desc = ":NavigatorUp" },
				{ "<C-j>", "<CMD>NavigatorDown<CR>", { "n" }, desc = ":NavigatorDown" },
				{ "<C-h>", "<C-\\><C-n><CMD>NavigatorLeft<CR>", { "t" }, desc = ":NavigatorLeft" },
				{ "<C-l>", "<C-\\><C-n><CMD>NavigatorRight<CR>", { "t" }, desc = ":NavigatorRight" },
				{ "<C-k>", "<C-\\><C-n><CMD>NavigatorUp<CR>", { "t" }, desc = ":NavigatorUp" },
				{ "<C-j>", "<C-\\><C-n><CMD>NavigatorDown<CR>", { "t" }, desc = ":NavigatorDown" },
			}
		end,
		config = function()
			require("Navigator").setup()
		end,
	},
}
