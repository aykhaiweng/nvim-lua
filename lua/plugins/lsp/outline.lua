return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = { -- Example mapping to toggle outline
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		config = function()
			require("outline").setup({
				preview_window = {
					auto_preview = false,
				},
				outline_items = {
					show_symbol_lineno = true,
				},
				outline_window = {
					width = 20,
					relative_width = true,
				},
				symbol_folding = {
					autofold_depth = 2,
					auto_unfold = {
						-- Auto unfold currently hovered symbol
						hovered = false,
						-- Auto fold when the root level only has this many nodes.
						-- Set true for 1 node, false for 0.
						only = true,
					},
				},
			})
		end,
	},
}
