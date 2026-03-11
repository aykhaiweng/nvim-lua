return {
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		lazy = true,
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
				{ "<leader>pf", builtin.find_files, "n", desc = "Find files" },
				{ "<leader>po", builtin.oldfiles, "n", desc = "Open recent" },
				{ "<C-p>", builtin.find_files, "n", desc = "Find files" },
				{
					"<C-f>",
					"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
					mode = {"n"},
					desc = "Live grep",
				},
				{
					"<C-f>",
					function()
						vim.cmd('noau normal! gv"vy')
						local selection = vim.fn.getreg("v")
						require("telescope").extensions.live_grep_args.live_grep_args({ default_text = selection })
					end,
					mode = {"v"},
					desc = "Live grep visual selection",
				},

				-- remaps for lsp
				{ "<leader>pr", builtin.lsp_references, "n", desc = "LSP References" },
				-- { "<leader>ps", builtin.lsp_workspace_symbols, "n", desc = "Worksymbols" },

				-- remaps for diagnostics
				{ "<leader>pd", builtin.diagnostics, "n", desc = "Diagnostics" },

				-- remaps for treesitter
				{ "<leader>ts", builtin.treesitter, "n", desc = "Treesitter" },
			}
		end,
		config = function()
			local actions = require("telescope.actions")

			local function compare_paths(a, b)
				if a == b then return false end
				local a_parts = vim.split(a, "/")
				local b_parts = vim.split(b, "/")
				local min_len = math.min(#a_parts, #b_parts)

				for i = 1, min_len do
					local a_part = a_parts[i]
					local b_part = b_parts[i]
					if a_part ~= b_part then
						local a_is_file = (i == #a_parts)
						local b_is_file = (i == #b_parts)

						if a_is_file and not b_is_file then
							return true
						elseif not a_is_file and b_is_file then
							return false
						else
							return a_part < b_part
						end
					end
				end
				return #a_parts < #b_parts
			end

			local default_file_ignore_patterns = {
				"^.git/",
				"node_modules/",
				"__pycache__/",
				"venv/",
				".DS_Store",
				".ruff_cache/*"
			}

			-- setup
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = default_file_ignore_patterns,
					color_devicons = true,
					prompt_prefix = "   ",
					path_display = { "truncate" },
					mappings = {
						i = {
							["<ESC>"] = actions.close,
							["<C-c>"] = actions.close,
							["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						},
					},
					sorting_strategy = "ascending",
                    sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
					tiebreak = function(current_entry, existing_entry, _)
						return compare_paths(current_entry.value, existing_entry.value)
					end,
					selection_strategy = "closest",
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden", -- This flag allows hidden files
						"--glob", -- This allows us to exclude specific folders
						"!{.git/*}", -- Exclude the .git directory (recommended)
					},
					layout_config = {
						vertical = {
							prompt_position = "top",
							width = {
								0.6,
								max = 120,
							},
						},
						horizontal = {
							prompt_position = "top",
							width = {
								0.8,
								max = 160,
							},
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						no_ignore = true,
					},
					live_grep = {
						file_ignore_patterns = default_file_ignore_patterns,
						hidden = true,
						no_ignore = true,
						additional_args = function(_)
							return { "--hidden" }
						end,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
					},
				},
			})

			-- extensions
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("live_grep_args")
		end,
	},
}
