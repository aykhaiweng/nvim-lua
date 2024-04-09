return {
	{
		"folke/trouble.nvim",
		branch = "dev",
        event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("trouble").setup({})

			vim.keymap.set("n", "<leader>ll", [[:Trouble loclist toggle<CR>]], { desc = "Open Location List" })
			vim.keymap.set("n", "<leader>ld", [[:Trouble diagnostics toggle filter.buf=0<CR>]], { desc = "Open Diagnostics (This buffer)" })
			vim.keymap.set("n", "<leader>lD", [[:Trouble diagnostics toggle<CR>]], { desc = "Open Diagnostics" })
		end,
	},
}
