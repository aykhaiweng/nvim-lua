return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Outline", "OutlineFocus" },
		opts = {
			outline_window = {
				winhl = "NormalFloat:",
			},
            outline_items = {
                auto_update_events = {
                    "CursorMove",
                },
            },
			preview_window = {
				winhl = "NormalFloat:",
			},
			icon_source = "lspkind",
		},
		keys = {
			{ "<leader>=", "<cmd>Outline<CR>", "n", desc = "Open Outline" },
		},
		config = function(_, opts)
			-- Example mapping to toggle outline
			require("outline").setup(opts)
		end,
	},
}
