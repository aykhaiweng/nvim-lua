return {
	{
		"lewis6991/hover.nvim",
		dependencies = {
			"ldelossa/gh.nvim",
		},
		keys = function()
			return {
				{ "K", require("hover").hover, "n", desc = "hover.nvim" },
				{
					"gK",
					require("hover").hover_select,
					"n",
					desc = "hover.nvim (select)",
				},
				{
					"<S-Tab>",
					function()
						require("hover").hover_switch("previous")
					end,
					"n",
					desc = "hover.nvim (previous source)",
				},
				{
					"<Tab>",
					function()
						require("hover").hover_switch("next")
					end,
					"n",
					desc = "hover.nvim (next source)",
				},
			}
		end,
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					require("hover.providers.gh_user")
					-- require('hover.providers.jira')
					-- require('hover.providers.man')
					-- require('hover.providers.dictionary')
				end,
				preview_opts = {
					border = "single",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = true,
				title = true,
				mouse_providers = {
					"LSP",
				},
			})
		end,
	},
}
