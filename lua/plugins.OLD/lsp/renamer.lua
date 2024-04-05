return {
	{
		"filipdutescu/renamer.nvim",
		branch = "master",
		lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
            print("lmao")
			local mappings_utils = require("renamer.mappings.utils")
			require("renamer").setup({
				mappings = {
					["<c-i>"] = mappings_utils.set_cursor_to_start,
					["<c-a>"] = mappings_utils.set_cursor_to_end,
					["<c-e>"] = mappings_utils.set_cursor_to_word_end,
					["<c-b>"] = mappings_utils.set_cursor_to_word_start,
					["<c-c>"] = mappings_utils.clear_line,
					["<c-u>"] = mappings_utils.undo,
					["<c-r>"] = mappings_utils.redo,
				},
			})
			vim.keymap.set(
				"n",
				"<leader>rn",
				'<cmd>lua require("renamer").rename()<cr>',
				{ noremap = true }
			)
			vim.keymap.set(
				"v",
				"<leader>rn",
				'<cmd>lua require("renamer").rename()<cr>',
				{ noremap = true }
			)
		end,
	},
}
