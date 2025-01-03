--- Formatting
return {
	"stevearc/conform.nvim",
	lazy = true,
	keys = function()
		local conform = require("conform")
		return {
			{
				"<leader>ff",
				function()
					conform.format({ async = true, timeout_ms = 3000 })
				end,
				desc = "Conform in file or range (visual)",
                mode = {"v", "n"}
			},
		}
	end,
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			svelte = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			htmldjango = { "djlint" },
			json = { "prettierd" },
			yaml = { "prettierd" },
			markdown = { "prettierd" },
			graphql = { "prettierd" },
			lua = { "stylua" },
			python = {
				"ruff_fix",
				"ruff_format",
				"ruff_organize_imports",
			},
		},
		timeout_ms = 3000,
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)
	end,
}
