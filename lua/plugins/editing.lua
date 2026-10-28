return {
	{
		"nvim-treesitter",
		lazy = false, -- the main branch doesn't support lazy-loading
		after = function()
			-- TODO(skeleton): parser list; highlighting via vim.treesitter.start in a FileType autocmd
		end,
	},
	{
		"blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			-- TODO(skeleton): sources lsp/path/snippets (snippets/ dir)/buffer; lazydev provider
		end,
	},
	{
		"flash.nvim",
		keys = {
			{ "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
			{ "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
		},
		after = function()
			require("flash").setup()
		end,
	},
	{
		"mini.nvim",
		event = "DeferredUIEnter",
		after = function()
			-- TODO(skeleton): mini.ai, mini.surround, mini.hipatterns (TODOs), mini.statusline, mini.sessions
		end,
	},
}
