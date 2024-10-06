return {
	{
		"stevearc/overseer.nvim",
		cmd = {
			"OverseerToggle",
			"OverseerRun",
		},
		keys = function()
			local dap = require("dap")
			return {
				{ "<leader>ot", "<cmd>OverseerToggle<CR>", "n", desc = "Overseer Toggle" },
				{ "<leader>or", "<cmd>OverseerRun<CR>", "n", desc = "Overseer Run" },
			}
		end,
		opts = {
			strategy = "toggleterm",
		},
		config = function(_, opts)
			require("overseer").setup(opts)
		end,
	},
}
