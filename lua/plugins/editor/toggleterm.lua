return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
				pattern = "term://*toggleterm#*",
				callback = function()
					vim.cmd("startinsert")
				end,
			})
		end,
		opts = {
			-- 1. Ensure it always opens at the bottom
			direction = "horizontal",
			size = 20,
			open_mapping = [[<F5>]], -- Integrated Lazy-loading trigger
		},
		keys = {
			{
				"<F5>",
				function()
					local term_ft = "toggleterm"
					-- Check if we are currently inside a toggleterm window
					if vim.bo.filetype == term_ft then
						vim.cmd("ToggleTerm")
					else
						-- If not, open or jump to terminal 1 at the bottom
						vim.cmd("1ToggleTerm direction=horizontal")
					end
				end,
				mode = { "n", "t", "i", "v" }, -- Normal, Terminal, and Insert modes
				desc = "Toggle/Focus Bottom Terminal",
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
