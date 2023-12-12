return {
	"f-person/git-blame.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		require("gitblame").setup({
			--Note how the `gitblame_` prefix is omitted in `setup`
			enabled = true,
		})
	end,
}
