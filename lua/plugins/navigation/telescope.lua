return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
        cmd = { "Telescope" },
		keys = function()
			local builtin = require("telescope.builtin")
			return {
				-- remaps
				{ "<leader>pf", builtin.find_files, "n", { desc = "Find files" } },
				{ "<leader>po", builtin.oldfiles, "n", { desc = "Open recent" } },
				{ "<C-p>", builtin.find_files, "n", { desc = "Find files" } },
				{
					"<C-f>",
					":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
					"n",
					{ desc = "Live grep" },
				},

				-- remaps for lsp
				{ "<leader>pr", builtin.lsp_references, "n", { desc = "LSP References" } },
				{ "<leader>ps", builtin.lsp_workspace_symbols, "n", { desc = "Worksymbols" } },

				-- remaps for diagnostics
				{ "<leader>pd", builtin.diagnostics, "n", { desc = "Diagnostics" } },

				-- remaps for treesitter
				{ "<leader>ts", builtin.treesitter, "n", { desc = "Treesitter" } },
			}
		end,
		config = function()
			local actions = require("telescope.actions")

			-- extensions
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")

			-- setup
			require("telescope").setup({
				defaults = {
					prompt_prefix = "   ",
					path_display = { "truncate" },
					mappings = {
						i = {
							["<ESC>"] = actions.close,
							["<C-c>"] = actions.close,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
					layout_config = {
						preview_width = 0.6,
						preview_cutoff = 120,
						height = 0.8,
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})
		end,
	},
}
