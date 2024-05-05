return {
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen", "OutlineFocus" },
		opts = {
            -- outline_items = {
            --     auto_update_events = {
            --         "CursorHold",
            --     },
            -- },
            outline_window = {
                width = 45,
                relative_width = false,
                winhl = "Normal:NvimTreeNormal"
            },
            symbol_folding = {
                autofold_depth = 1,
                auto_unfold = {
                    hovered = true
                }
            },
			icon_source = "lspkind",
            keymaps = {
                down_and_jump = "<M-j>",  -- Unbind CTRL-J
                up_and_jump = "<M-k>" -- Unbind CTRL-K
            }
		},
		keys = {
			{ "<leader>=", "<cmd>OutlineOpen<CR><cmd>OutlineFocus<CR>", "n", desc = "Open Outline" },
			{ "<leader>+", "<cmd>OutlineClose<CR>", "n", desc = "Close Outline" },
		},
		config = function(_, opts)
			-- Example mapping to toggle outline
			require("outline").setup(opts)
		end,
	},
}
