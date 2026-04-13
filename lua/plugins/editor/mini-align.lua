return {
	"echasnovski/mini.align",
	version = "*",
	config = function()
		require("mini.align").setup()
	end,
	keys = {
		{ "ga", mode = { "n", "v" }, desc = "Align" },
		{ "gA", mode = { "n", "v" }, desc = "Align with preview" },
	},
}
