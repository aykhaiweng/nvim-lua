return {
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				-- winbar config
				symbol_in_winbar = {
					enable = true,
					delay = 100,
				},
				-- outline config
				outline = {
					win_position = "right",
					win_width = 50,
					detail = true,
				},
				lines = { "┗", "┣", "┃", "━", "┏" },
                lightbulb = {
                    enable = false
                }
			})
			require("lspsaga.symbol.winbar").get_bar()

			vim.keymap.set("n", "<leader>=", [[:Lspsaga outline<CR>]])
			vim.keymap.set("n", "K", [[:Lspsaga hover_doc<CR>]])
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
