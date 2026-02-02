--- Linting
return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile", "InsertLeave" },
	init = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Attempt to lint when entering a buffer.
		vim.api.nvim_create_autocmd({ "BufReadpre" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Attempt to lint while typing
		vim.api.nvim_create_autocmd({
			"BufEnter",
			"BufWritePost",
			"BufReadPre",
			"TextChanged",
			"InsertLeave",
		}, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
	keys = function()
		local lint = require("lint")
		return {
			{
				"<leader>fl",
				function()
					lint.try_lint()
				end,
				"n",
				desc = "Trigger linting for current file",
			},
		}
	end,
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			-- python = { "ruff" },
			json = { "jsonlint" },
		}
	end,
}
