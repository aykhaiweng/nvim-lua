return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	enabled = false,
	opts = {
		adapters = {
			acp = {
				gemini_cli = function()
					return require("codecompanion.adapters").extend("gemini_cli", {
						defaults = {
							auth_method = "gemini-api-key", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
						},
					})
				end,
			},
		},
		strategies = {
			chat = {
				adapter = "gemini_cli",
			},
			inline = {
				adapter = "gemini",
			},
		},
		opts = {
			log_level = "DEBUG",
		},
	},
	config = function(_, opts)
		require("codecompanion").setup(opts)

		-- Keymaps for CodeCompanion
		vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion Chat" })
		vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Inline" })
		vim.keymap.set({ "n", "v" }, "ga", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
	end,
}
