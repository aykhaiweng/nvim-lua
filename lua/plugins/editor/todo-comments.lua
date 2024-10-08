return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function(_, opts)
			require("todo-comments").setup(opts)
			vim.keymap.set("n", "]t", function()
				require("todo-comments").jump_next()
			end, { desc = "next todo comment" })

			vim.keymap.set("n", "[t", function()
				require("todo-comments").jump_prev()
			end, { desc = "previous todo comment" })
		end,
	},
}
