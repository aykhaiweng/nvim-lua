return {
	{
		"echasnovski/mini.splitjoin",
		version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			require("mini.splitjoin").setup()
		end,
	},
}
