return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen", "OutlineFocus" },
		opts = {
			outline_items = {
				show_symbol_details = true,
				show_symbol_lineno = false,
				highlight_hovered_item = true,
				auto_set_cursor = true,
				auto_update_events = {
					follow = { "CursorHold" },
					items = {
                        "InsertLeave",
                        "WinEnter",
                        "BufEnter",
                        "BufWinEnter",
                        "TabEnter",
                        "BufWritePost",
                    },
				},
			},
			outline_window = {
				width = 40,
				relative_width = false,
				winhl = "Normal:EdgyNormal",
			},
			symbol_folding = {
				autofold_depth = 2,
				auto_unfold = {
					hovered = true,
				},
			},
			icon_source = "lspkind",
			keymaps = {
				down_and_jump = "<M-j>", -- Unbind CTRL-J
				up_and_jump = "<M-k>", -- Unbind CTRL-K
			},
            focus_on_open = false
		},
		keys = {
			{ "<leader>=", "<cmd>OutlineOpen<CR>", "n", desc = "Open Outline" },
			{ "<leader>+", "<cmd>OutlineClose<CR>", "n", desc = "Close Outline" },
		},
		config = function(_, opts)
			-- Example mapping to toggle outline
			require("outline").setup(opts)
		end,
	},
}
