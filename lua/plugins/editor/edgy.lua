return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
			vim.opt.equalalways = true
		end,
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
						size = 50,
					},
					right = {
						size = 50,
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
				right = {},
				bottom = {
					-- {
					-- 	title = "Terminal",
					-- 	ft = "toggleterm",
					-- 	filter = function(buf, win) -- noqa
					-- 		return vim.api.nvim_win_get_config(win).relative == ""
					-- 	end,
					-- },
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

			local function custom_edgy_open()
				-- -- Save the current window ID
				local current_win = vim.api.nvim_get_current_win()

				-- Open Edgy panels
				require("edgy").open()

				-- Defer the focus restoration
				vim.schedule(function()
					-- Ensure the window still exists before focusing
					if vim.api.nvim_win_is_valid(current_win) then
						vim.api.nvim_set_current_win(current_win)
					end
				end)
			end

			custom_edgy_open()

			--- Auto open edgy windows
			vim.api.nvim_create_autocmd({ "TabNew" }, {
				desc = "Auto-open pinned edgy views on startup",
				callback = function()
					custom_edgy_open()
				end,
			})
		end,
	},
}
