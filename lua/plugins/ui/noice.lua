return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = true,
		opts = {
			-- add any options here
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
			lsp = {
				signature = {
					enabled = false,
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
			require("lualine").setup({
				sections = {
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
				},
			})
		end,
	},
}
