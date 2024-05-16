return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
        enabled = false,
        opts = {},
		config = function(_, opts)
			require("dashboard").setup(opts)
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
