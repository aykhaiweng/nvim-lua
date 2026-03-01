return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
			vim.opt.equalalways = true
		end,
		keys = function()
			return {
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
			}
		end,
		opts = function()
			local opts = {
				animate = {
					enabled = false,
				},
				exit_when_last = true,
				-- close_when_all_hidden = true,
				keep_win_size = true,
				wo = {
					winbar = true,
					winfixwidth = true,
					winfixheight = true,
					winhighlight = "",
					spell = false,
					signcolumn = "no",
				},
				options = {
					left = { size = 50 },
					right = { size = 50 },
					bottom = { size = 25 },
				},
				left = {
					{
						title = "Git",
						ft = "neo-tree",
						pinned = true,
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "git_status"
						end,
						open = "Neotree position=top git_status",
						size = { height = 0.15 },
						wo = {
							winfixwidth = true,
						},
					},
					{
						title = "Files",
						ft = "neo-tree",
						filter = function(buf)
							return vim.b[buf].neo_tree_source == "filesystem"
						end,
						pinned = true,
						open = "Neotree position=left filesystem",
						size = { height = 0.5 },
						wo = {
							winfixwidth = true,
						},
					},
					{
						title = "Outline",
						ft = "Outline",
						pinned = true,
						open = function()
							vim.cmd("OutlineOpen")
						end,
						size = { height = 0.25 },
						wo = {
							winfixwidth = true,
						},
					},
				},
				bottom = {
					{
						title = "Terminal",
						ft = "toggleterm",
						height = 0.4,
						filter = function(buf, win) -- noqa
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
						wo = {
							winfixheight = true,
						},
					},
					{
						title = "Noice",
						ft = "noice",
						height = 0.4,
						filter = function(buf, win) -- noqa
							return vim.api.nvim_win_get_config(win).relative == ""
						end,
						wo = {
							winfixheight = true,
						},
					},
					{
						title = "Quickfix",
						ft = "qf",
						wo = {
							winfixheight = true,
						},
					},
					"loclist",
					"fugitive",
					"NeogitStatus",
					"Trouble",
					{
						ft = "help",
						size = { height = 20 },
						-- don't open help files in edgy that we're editing
						filter = function(buf)
							return vim.bo[buf].buftype == "help"
						end,
						wo = {
							winfixheight = true,
						},
					},
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
				require("edgy").open()
			end

			custom_edgy_open()

			--- Auto open edgy windows
			vim.api.nvim_create_autocmd({ "TabNew" }, {
				desc = "Auto-open pinned edgy views on startup",
				callback = function()
					custom_edgy_open()
				end,
			})

			-- Smart window balancing that respects edgy.nvim
			vim.keymap.set("n", "<leader>w=", function()
				-- 1. Equalize all windows using standard Neovim logic
				vim.cmd("wincmd =")

				-- 2. Force edgy to fix the layouts it manages
				local ok, edgy = pcall(require, "edgy")
				if ok then
					-- This resets edgy windows to their configured fixed sizes
					edgy.fix()
				end
			end, { desc = "Balance windows (respecting edgy)" })
		end,
	},
}
