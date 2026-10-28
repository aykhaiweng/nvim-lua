local function nav(direction)
	return function() require("smart-splits")["move_cursor_" .. direction]() end
end
local function resize(direction)
	return function() require("smart-splits")["resize_" .. direction]() end
end

return {
	{
		-- Ctrl-hjkl/Alt-hjkl cross into zellij panes; zellij's vim-zellij-navigator
		-- forwards the keys here when nvim is focused.
		"smart-splits.nvim",
		keys = {
			{ "<C-h>", nav("left"), mode = { "n", "t" }, desc = "Move to left split" },
			{ "<C-j>", nav("down"), mode = { "n", "t" }, desc = "Move to lower split" },
			{ "<C-k>", nav("up"), mode = { "n", "t" }, desc = "Move to upper split" },
			{ "<C-l>", nav("right"), mode = { "n", "t" }, desc = "Move to right split" },
			{ "<A-h>", resize("left"), mode = { "n", "t" }, desc = "Resize split left" },
			{ "<A-j>", resize("down"), mode = { "n", "t" }, desc = "Resize split down" },
			{ "<A-k>", resize("up"), mode = { "n", "t" }, desc = "Resize split up" },
			{ "<A-l>", resize("right"), mode = { "n", "t" }, desc = "Resize split right" },
		},
		after = function()
			require("smart-splits").setup({ multiplexer_integration = "zellij" })
		end,
	},
	{
		"claudecode.nvim",
		cmd = { "ClaudeCode", "ClaudeCodeSend", "ClaudeCodeAdd" },
		after = function()
			-- TODO(skeleton): open question — Claude in a zellij pane (external
			-- terminal provider) or an nvim terminal split
		end,
	},
}
