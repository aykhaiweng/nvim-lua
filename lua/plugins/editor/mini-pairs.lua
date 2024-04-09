return {
	{
		"echasnovski/mini.pairs",
		version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			require("mini.pairs").setup()
		end,
	},
}
