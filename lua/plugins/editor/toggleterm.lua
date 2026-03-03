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
			local Terminal = require("toggleterm.terminal").Terminal

			local main_term = Terminal:new({
				id = 1,
				float_opts = {
					border = "curved",
					width = math.floor(vim.o.columns * 0.6),
					height = math.floor(vim.o.lines * 0.8),
				},
			})

			local function smart_toggle(target_direction)
				local current_tab = vim.api.nvim_get_current_tabpage()
				local current_win = vim.api.nvim_get_current_win()

				-- 1. Identify the terminal's buffer and find if it's visible anywhere
				local term_buf = main_term.bufnr
				local term_win_id = nil
				local term_tab_id = nil

				if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
					-- Scan all tabs to find the terminal window
					for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
						for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
							if vim.api.nvim_win_get_buf(win) == term_buf then
								term_win_id = win
								term_tab_id = tab
								break
							end
						end
						if term_win_id then
							break
						end
					end
				end

				-- 2. Scenario: Terminal is NOT visible anywhere
				if not term_win_id then
					main_term.direction = target_direction
					main_term:open()
					return
				end

				-- 3. Scenario: Terminal is visible in CURRENT tab
				if term_tab_id == current_tab then
					-- Check actual layout (Float vs Split)
					local win_config = vim.api.nvim_win_get_config(term_win_id)
					local is_floating = win_config.relative ~= ""
					local want_floating = (target_direction == "float")

					if is_floating ~= want_floating then
						-- Wrong shape: Close and Reopen correct shape
						main_term:close()
						main_term.direction = target_direction
						main_term:open()
					else
						-- Correct shape: Toggle Focus
						if current_win == term_win_id then
							main_term:close() -- We are in it, close
						else
							vim.api.nvim_set_current_win(term_win_id) -- Just focus, don't reopen
							vim.cmd("startinsert")
						end
					end
					return
				end

				-- 4. Scenario: Terminal is visible in ANOTHER tab (The Fix)
				if term_tab_id ~= current_tab then
					-- Crucial: Manually close the remote window without switching tabs
					vim.api.nvim_win_close(term_win_id, true)

					-- Reset internal state so toggleterm knows it's closed
					main_term.window = nil

					-- Open in current tab
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
					mode = { "n", "t", "v", "i" },
					desc = "Toggle/Focus bottom Terminal",
				},
				{
					"<F6>",
					function()
						smart_toggle("float")
					end,
					mode = { "n", "t", "v", "i" },
					desc = "Open floating Terminal",
				},
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
