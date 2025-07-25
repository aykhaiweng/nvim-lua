return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the four listed parsers should always be installed)
				ensure_installed = {
					"gitignore",
					"dockerfile",
					"lua",
					"vim",
					"comment",
					"markdown",
					"markdown_inline",
					"json",
					"rst",
					"python",
					"html",
					"css",
					"javascript",
				},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
			})

			-- -- Folding fun times
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			-- vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
			-- vim.opt.foldlevelstart = 99
			-- vim.opt.foldlevel = 99
		end,
	},
	-- Treesitter Context
	-- {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- },
	-- Playground
	{
		"nvim-treesitter/playground",
		event = { "BufReadPre", "BufNewFile" },
	},
	-- Sphinx
	{
		"stsewd/sphinx.nvim",
		event = { "BufReadPre", "BufNewFile" },
	},
	-- Fixing % motions
	{
		"yorickpeterse/nvim-tree-pairs",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		config = function(_, opts)
			require("tree-pairs").setup(opts)
		end,
	},
}
