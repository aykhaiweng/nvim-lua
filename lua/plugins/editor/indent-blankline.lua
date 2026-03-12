return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		enabled = false,
		opts = {
			scope = {
				enabled = false,
			},
			exclude = {
				-- language = {
				-- 	"lua",
				-- },
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
}
