return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
        lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local harpoon = require("harpoon")
			return {
				{
					"<leader>a",
					function()
						harpoon:list():add()
					end,
					"n",
					{ desc = "Add to Harpoon" },
				},
				{
					"<C-e>",
					function()
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					"n",
					{ desc = "Open Harpoon" },
				},
			}
		end,
		config = function()
			local harpoon = require("harpoon")

			harpoon:setup({})
		end,
	},
}
