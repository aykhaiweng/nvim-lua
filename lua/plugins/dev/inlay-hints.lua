return {
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		keys = {
			{ "<leader>vh", "<CMD>InlayHintsToggle<cr>", desc = "Toggle Inlay Hints" },
		},
		config = function()
			require("inlay-hints").setup()
		end,
	},
}
