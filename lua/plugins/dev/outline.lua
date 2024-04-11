return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Outline", "OutlineFocus" },
		opts = {
			auto_update_events = {
				"CursorHold",
			},
			outline_window = {
				winhl = "NormalFloat:",
			},
			preview_window = {
				winhl = "NormalFloat:",
			},
			icon_source = "lspkind",
		},
		keys = {
			{ "<leader>=", "<cmd>OutlineOpen<CR><cmd>OutlineFocus<CR>", "n", desc = "Open Outline" },
		},
		config = function(_, opts)
			-- Example mapping to toggle outline
			require("outline").setup(opts)
		end,
	},
}
