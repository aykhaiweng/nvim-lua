return {
	{
		"lewis6991/gitsigns.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = {
						text = "▎",
					},
					delete = {
						text = "_",
					},
					topdelete = {
						text = "‾",
					},
					changedelete = {
						text = "▎",
					},
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 0,
					ignore_whitespace = true,
				},
				current_line_blame_formatter = "   <author>, <author_time:%R> · <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Actions
					map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
					map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
					map("v", "<leader>gs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Stage selection" })
					map("v", "<leader>gr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { desc = "Reset selection" })
					map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
					map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
					map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
					map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
					map("n", "<leader>gb", function()
						gitsigns.blame_line({ full = true })
					end, { desc = "Blame line" })
					map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
					map("n", "<leader>gD", function()
						gitsigns.diffthis("~")
					end, { desc = "Diff this ~" })

					-- Toggle Virtual Text
					map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
					map("n", "<leader>gd", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

					-- Text objecht
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
}
