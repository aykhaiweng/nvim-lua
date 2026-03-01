return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
				pattern = "term://*toggleterm#*",
				callback = function()
					vim.cmd("startinsert")
				end,
			})
		end,
		opts = {
			-- 1. Ensure it always opens at the bottom
			direction = "horizontal",
			size = 20,
		},
		keys = function()
			-- Require the Terminal object from toggleterm
			local Terminal = require("toggleterm.terminal").Terminal

			-- Create a single reference to the default terminal (ID 1)
			local main_term = Terminal:new({
				id = 1,
				float_opts = {
					border = "curved",
					width = math.floor(vim.o.columns * 0.6),
					height = math.floor(vim.o.lines * 0.8),
				},
			})

			-- Centralized smart toggle function
			local function smart_toggle(target_direction)
				-- 1. If terminal is open but in the wrong layout (e.g., it is floating but we pressed C-t)
				if main_term:is_open() and main_term.direction ~= target_direction then
					main_term:close()
					main_term.direction = target_direction
					main_term:open()
					return
				end

				-- 2. If it's completely closed, set the desired layout and open
				if not main_term:is_open() then
					main_term.direction = target_direction
					main_term:open()
					return
				end

				-- 3. If it's open AND in the correct layout, handle tab jumping and focus
				local win = main_term.window
				if win and vim.api.nvim_win_is_valid(win) then
					local term_tab = vim.api.nvim_win_get_tabpage(win)
					local current_tab = vim.api.nvim_get_current_tabpage()

					if term_tab == current_tab then
						-- Focus if we aren't in it, close if we are
						if vim.api.nvim_get_current_win() ~= win then
							vim.api.nvim_set_current_win(win)
							vim.cmd("startinsert")
						else
							main_term:close()
						end
					else
						-- Move from another tab
						local saved_tab = vim.api.nvim_get_current_tabpage()
						main_term:close()
						if vim.api.nvim_get_current_tabpage() ~= saved_tab then
							vim.api.nvim_set_current_tabpage(saved_tab)
						end
						main_term.direction = target_direction
						main_term:open()
					end
				else
					-- Fallback if the window state detached
					main_term.direction = target_direction
					main_term:open()
				end
			end
			return {
				{
					"<F5>",
					function()
						smart_toggle("horizontal")
					end,
					mode = { "n", "t", "v", "i" }, -- Normal, Terminal, Insert and Visual modes
					desc = "Toggle/Focus bottom Terminal",
				},
				{
					"<F6>",
					function()
						smart_toggle("float")
					end,
					mode = { "n", "t", "v", "i" }, -- Normal, Terminal, Insert and Visual modes
					desc = "Open floating Terminal",
				},
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
