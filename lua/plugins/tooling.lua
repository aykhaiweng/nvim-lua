return {
	{
		"conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		after = function()
			-- TODO(skeleton): formatters_by_ft (ruff, stylua, shfmt, prettier), format_on_save
		end,
	},
	{
		"nvim-lint",
		event = { "BufReadPost", "BufWritePost" },
		after = function()
			-- TODO(skeleton): linters_by_ft and the try_lint autocmd
		end,
	},
	{
		"gitsigns.nvim",
		event = "BufReadPre",
		after = function()
			-- TODO(skeleton): hunk navigation and staging keymaps
		end,
	},
	{
		"lazydev.nvim",
		ft = "lua",
		after = function()
			require("lazydev").setup()
		end,
	},
}
