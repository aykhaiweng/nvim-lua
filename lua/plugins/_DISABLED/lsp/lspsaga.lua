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
					enable = false,
				},
				diagnostic = {
					enable = true,
					diagnostic_only_current = true,
				},
			})
			-- Triggers the tag bar to run
			require("lspsaga.symbol.winbar").get_bar()

			-- show outline
			vim.keymap.set("n", "<leader>=", [[:Lspsaga outline<CR>]])
			-- show documentation
			vim.keymap.set("n", "K", [[:Lspsaga hover_doc<CR>]]) -- overrides lsp-zero
			vim.keymap.set("n", "gd", [[:Lspsaga peek_definition<CR>]]) -- overrides lsp-zero
			-- Jump between diagnostic items
			vim.keymap.set("n", "[e", [[:Lspsaga diagnostic_jump_prev<CR>]])
			vim.keymap.set("n", "]e", [[:Lspsaga diagnostic_jump_next<CR>]])
			-- Rename items
			vim.keymap.set("n", "<leader>rr", [[:Lspsaga rename<CR>]])
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
