--- Navigation for TMUX using smart-splits
return {
	"mrjones2014/smart-splits.nvim",
	lazy = false, -- Important for initial keymaps
	opts = {
		-- Ignored filetypes (can be used to disable smart-splits for specific buffers)
		ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
		-- Ignored buffer types
		ignored_buftypes = { "nofile" },
	},
	keys = {
		-- Moving between splits
		{ "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
		{ "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to down split" },
		{ "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to up split" },
		{ "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
		-- Resizing splits
		{ "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
		{ "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
		{ "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
		{ "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
	},
}
