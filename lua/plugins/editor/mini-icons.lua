return {
	"echasnovski/mini.icons",
	version = "*",
	opts = {
		style = "glyph",
	},
	config = function(_, opts)
		require("mini.icons").setup(opts)
	end,
}
