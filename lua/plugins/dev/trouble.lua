return {
	{
		"folke/trouble.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>ll",
				function()
					require("trouble").toggle()
				end,
				"n",
				desc = "Open Location List",
			},
			{
				"<leader>ld",
				function()
					require("trouble").toggle("document_diagnostics")
				end,
				"n",
				desc = "Open Diagnostics",
			},
			{
				"<leader>lD",
				function()
					require("trouble").toggle("workspace_diagnostics")
				end,
				"n",
				desc = "Open Workspace Diagnostics",
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
