return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			-- add any options here
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			lsp = {
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true,
					},
					opts = { focusable = true },
				},
				hover = {
					enabled = true,
					opts = { focusable = true },
				},
			},
		},
        keys = {
			{ "<F8>", "<cmd>Noice all<CR>", "n", desc = "Open Noice all" },
        },
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function(_, opts)
			require("noice").setup(opts)
		end,
	},
}
