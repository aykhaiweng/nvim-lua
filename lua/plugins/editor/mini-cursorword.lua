return {
	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			require("mini.cursorword").setup({
				delay = 100,
			})
		end,
	},
}
