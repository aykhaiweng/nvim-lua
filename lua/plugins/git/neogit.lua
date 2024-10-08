return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
		"echasnovski/mini.pick", -- optional
	},
	keys = {
			{ "<leader>gg", [[:Neogit kind=split<CR>]], desc = "Neogit" },
	},
	opts = {},
	config = function(_, opts)
		require("neogit").setup(opts)
	end,
}
