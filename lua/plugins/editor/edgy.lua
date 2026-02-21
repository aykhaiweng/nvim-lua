return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<C-b>",
				function()
					require("edgy").toggle("left", { focus = false })
				end,
				desc = "Edgy Toggle",
			},
			{
				"<C-S-B>",
				function()
					require("edgy").open({ focus = false })
				end,
				desc = "Edgy Toggle",
			},
			{
				"<leader>we",
				function()
					require("edgy").select()
				end,
				desc = "Edgy Select Window",
			},
		},
		opts = function()
			local opts = {
				animate = {
					enabled = false,
				},
				exit_when_last = false,
				close_when_all_hidden = true,
				wo = {
					winbar = true,
					winfixwidth = true,
					winfixheight = true,
					winhighlight = "",
					spell = false,
					signcolumn = "no",
				},
				--- Force layout correction on every edgy-related event
				on_layout = function()
					vim.schedule(function()
						vim.cmd("redraw!")
						require("edgy").goto_main()
					end)
				end,
				--- Panel sizes
				options = {
					left = {
						size = 45,
					},
					right = {
						size = 45,
					},
					bottom = {
						size = 20,
					},
				},
				left = {
					{
						title = "Files",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "filesystem"
						end,
						pinned = true,
						open = "Neotree position=left filesystem",
						size = { height = 0.7 },
					},
					-- {
					-- 	title = "Git",
					-- 	ft = "neo-tree",
					-- 	pinned = true,
					-- 	filter = function(buf)
					-- 		return vim.b[buf].neo_tree_source == "git_status"
					-- 	end,
					-- 	open = "Neotree position=bottom git_status",
					-- 	size = { height = 0.15 },
					-- },
					-- {
					-- 	title = "Buffers",
					-- 	ft = "neo-tree",
					-- 	filter = function(buf)
					-- 		return vim.b[buf].neo_tree_source == "buffers"
					-- 	end,
					-- 	pinned = true,
					-- 	open = "Neotree position=top buffers",
					-- 	size = { height = 0.15 },
					-- },
				},
				right = {
					{
						title = "Outline",
						ft = "Outline",
						pinned = true,
						open = function()
							vim.cmd("OutlineOpen")
						end,
						size = { height = 0.5 },
					},
				},
				bottom = {
					{
						title = "Terminal",
						ft = "toggleterm",
						filter = function(buf, win) -- noqa
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
					},
					"qf",
					"loclist",
					"fugitive",
					"NeogitStatus",
					"trouble",
					"help",
				},
				keys = {
					-- increase width
					["<M-l>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<M-h>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<M-k>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<M-j>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}
			return opts
		end,
		config = function(_, opts)
			require("edgy").setup(opts)

			--- vim options as recommended by the edgy documentation
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
			vim.opt.equalalways = true

			--- Auto open edgy windows
			vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
				desc = "Auto-open pinned edgy views on startup",
				callback = function()
					-- Opens all pinned views in all edgebars
					require("edgy").open()
				end,
			})

			--- Auto open when detecting new diagnostics
			-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
			-- 	command = "Trouble diagnostics open",
			-- })
		end,
	},
}
