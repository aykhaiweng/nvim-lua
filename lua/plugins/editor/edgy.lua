return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		enabled = true,
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
			vim.opt.equalalways = false
		end,
		keys = function()
			local function toggle_edgy()
				require("edgy").toggle("left", { focus = false })
			end

			return {
				{
					"<C-b>",
					toggle_edgy,
					desc = "Edgy Toggle",
				},
				{
					"<C-S-B>",
					function()
						require("edgy").open({ focus = false })
					end,
					desc = "Edgy Open",
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
			local winhighlight = "Normal:Normal,NormalNC:NeoTreeNormalNC,EndOfBuffer:NeoTreeEndOfBuffer"
			local opts = {
				animate = {
					enabled = false,
				},
				exit_when_last = true,
				keep_win_size = false,
				wo = {
					winbar = true,
					winfixwidth = true,
					winfixheight = true,
					spell = false,
					signcolumn = "no",
					winhighlight = winhighlight,
				},
				options = {
					left = { size = 50 },
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
						ft = "terminal",
						height = 0.4,
						filter = function(buf, win) -- noqa
							return vim.api.nvim_win_get_config(win).relative == ""
								and vim.b[buf].terminal_position == "bottom"
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
				require("edgy").open({ focus = false })
			end

			custom_edgy_open()

			--- Auto open edgy windows
			vim.api.nvim_create_autocmd({ "TabNew", "TabEnter" }, {
				desc = "Auto-open pinned edgy views on tab enter",
				callback = function()
					vim.schedule(custom_edgy_open)
				end,
			})

			--- Robust window balancing for edgy
			local function balance_editors()
				local ok, edgy = pcall(require, "edgy")
				local wins = vim.api.nvim_tabpage_list_wins(0)

				-- 1. Ensure all edgy windows have winfix set so wincmd = ignores them
				for _, win in ipairs(wins) do
					if ok and edgy.get_win(win) then
						vim.wo[win].winfixwidth = true
						vim.wo[win].winfixheight = true
					else
						vim.wo[win].winfixwidth = false
						vim.wo[win].winfixheight = false
					end
				end

				-- 2. Initial pass with Neovim balancer
				if ok then edgy.fix() end
				vim.cmd("wincmd =")

				-- 3. Manually fix vertical heights for editors in each column
				vim.schedule(function()
					if not vim.api.nvim_tabpage_is_valid(0) then return end
					
					if ok then edgy.fix() end
					vim.cmd("redraw")

					local current_wins = vim.api.nvim_tabpage_list_wins(0)
					local columns = {}
					for _, win in ipairs(current_wins) do
						if not (ok and edgy.get_win(win)) and vim.api.nvim_win_get_config(win).relative == "" then
							local pos = vim.api.nvim_win_get_position(win)
							local x = pos[2]
							columns[x] = columns[x] or {}
							table.insert(columns[x], win)
						end
					end

					for _, col_wins in pairs(columns) do
						if #col_wins > 1 then
							-- Sort top to bottom
							table.sort(col_wins, function(a, b)
								return vim.api.nvim_win_get_position(a)[1] < vim.api.nvim_win_get_position(b)[1]
							end)

							local total_h = 0
							for _, win in ipairs(col_wins) do
								total_h = total_h + vim.api.nvim_win_get_height(win)
							end

							local avg_h = math.floor(total_h / #col_wins)
							local remainder = total_h % #col_wins

							-- Set heights for EVERY window in the column
							for i, win in ipairs(col_wins) do
								local h = avg_h + (i <= remainder and 1 or 0)
								pcall(vim.api.nvim_win_set_height, win, h)
							end
						end
					end
					
					if ok then edgy.fix() end
				end)
			end

			vim.keymap.set("n", "<leader>w=", balance_editors, { desc = "Balance windows (respecting edgy)" })
		end,
	},
}
