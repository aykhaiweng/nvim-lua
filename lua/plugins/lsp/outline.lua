return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen", "OutlineFocus" },
		opts = {
			outline_items = {
				-- Show extra details with the symbols (lsp dependent) as virtual next
				show_symbol_details = true,
				-- Show corresponding line numbers of each symbol on the left column as
				-- virtual text, for quick navigation when not focused on outline.
				-- Why? See this comment:
				-- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
				show_symbol_lineno = false,
				-- Whether to highlight the currently hovered symbol and all direct parents
				highlight_hovered_item = true,
				-- Whether to automatically set cursor location in outline to match
				-- location in code when focus is in code. If disabled you can use
				-- `:OutlineFollow[!]` from any window or `<C-g>` from outline window to
				-- trigger this manually.
				auto_set_cursor = true,
				-- Autocmd events to automatically trigger these operations.
				auto_update_events = {
					-- Includes both setting of cursor and highlighting of hovered item.
					-- The above two options are respected.
					-- This can be triggered manually through `follow_cursor` lua API,
					-- :OutlineFollow command, or <C-g>.
					follow = { "CursorHold" },
					-- Re-request symbols from the provider.
					-- This can be triggered manually through `refresh_outline` lua API, or
					-- :OutlineRefresh command.
					items = { "InsertLeave", "WinEnter", "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" },
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
