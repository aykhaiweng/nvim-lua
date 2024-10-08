return {
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		keys = {
			{ "<leader>vh", "<CMD>InlayHintsToggle<cr>", desc = "Toggle Inlay Hints" },
		},
        opts = {
            autocmd = { enable = false }
        },
		config = function(_, opts)
			require("inlay-hints").setup(opts)
		end,
	},
}
