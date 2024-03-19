return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		config = function()
			local builtin = require("telescope.builtin")
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
                        hidden = true
                    }
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

			-- remaps
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>pr", builtin.oldfiles, {})
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
            -- vim.keymap.set("n", "<C-f>", builtin.live_grep, {})
            vim.keymap.set("n", "<C-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

			-- remaps for lsp
			vim.keymap.set("n", "<leader>plr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>pls", builtin.lsp_workspace_symbols, {})

			-- remaps for diagnostics
			vim.keymap.set("n", "<leader>pld", builtin.diagnostics, {})

			-- remaps for treesitter
			vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
