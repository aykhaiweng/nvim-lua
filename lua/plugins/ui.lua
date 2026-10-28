-- lz.n specs: [1] is the vim.pack directory name; triggers decide load time.
return {
	{
		"catppuccin",
		colorscheme = { "catppuccin", "catppuccin-mocha" },
		lazy = false, -- needed on the first frame
		priority = 1000,
		after = function()
			-- TODO(skeleton): flavour "mocha" to match zellij, integrations
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"snacks.nvim",
		lazy = false, -- picker/explorer/notifier hook in at startup
		after = function()
			-- TODO(skeleton): picker, explorer, terminal, zen, notifier
		end,
	},
	{
		"which-key.nvim",
		event = "DeferredUIEnter",
		after = function()
			-- TODO(skeleton): leader group labels
		end,
	},
}
