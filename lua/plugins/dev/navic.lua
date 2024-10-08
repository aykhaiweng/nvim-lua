return {
	"SmiteshP/nvim-navic",
	opts = {
		lazy_update_context = false,
		highlight = true,
		click = true,
		lsp = {
			auto_attach = true,
		},
	},
	config = function(_, opts)
		require("nvim-navic").setup(opts)
	end,
}
