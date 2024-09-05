return {
	"stevearc/conform.nvim",
	lazy = true,
	keys = function()
		local conform = require("conform")
		return {
			{
				"<leader>ff",
				function()
					conform.format({timeout_ms = 3000})
				end,
				desc = "Conform in file or range (visual)",
			},
		}
	end,
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			svelte = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			graphql = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
		},
		timeout_ms = 3000,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)
	end,
}
