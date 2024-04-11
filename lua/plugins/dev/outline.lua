return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			{
				outline_window = {
					winhl = "NormalFloat:",
				},
				preview_window = {
					winhl = "NormalFloat:",
				},
				icon_source = "lspkind",
			},
		},
		config = function(opts)
			-- Example mapping to toggle outline
			vim.keymap.set("n", "<leader>=", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
			require("outline").setup(opts)
		end,
	},
}
