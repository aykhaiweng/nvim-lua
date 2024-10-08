return {
	{
		"folke/trouble.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>lD",
				"<cmd>Trouble diagnostics toggle<cr>",
				"n",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>ld",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>ll",
				"<cmd>Trouble loclist toggle<cr>",
				"n",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>lq",
				"<cmd>Trouble qflist toggle<cr>",
				"n",
				desc = "Quickfix List (Trouble)",
			},
		},
		cmd = { "Trouble" },
		config = function()
			require("trouble").setup({
				mode = "workspace_diagnostics",
				auto_preview = false,
			})
		end,
	},
}
