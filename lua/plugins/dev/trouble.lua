return {
	{
		"folke/trouble.nvim",
		branch = "dev",
		event = { "BufReadPre", "BufNewFile" },
        keys = {
            {"<leader>ll", [[:Trouble loclist toggle<CR>]], "n", desc = "Open Location List" },
            {"<leader>ld", [[:Trouble diagnostics toggle filter.buf=0<CR>]], "n", desc = "Open Diagnostics (This buffer)" },
            {"<leader>lD", [[:Trouble diagnostics toggle<CR>]], "n", desc = "Open Diagnostics" },
        },
		config = function()
			require("trouble").setup()
		end,
	},
}
