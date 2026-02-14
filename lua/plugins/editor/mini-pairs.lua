return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		lazy = false,
		enabled = false,
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
}
