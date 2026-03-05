return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		enabled = false,
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
			local terminals = {}

			local function smart_toggle(target_direction, id, cmd)
				id = id or 1
				if not terminals[id] then
					terminals[id] = Terminal:new({
						id = id,
						cmd = cmd,
						float_opts = {
							border = "curved",
							width = math.floor(vim.o.columns * 0.6),
							height = math.floor(vim.o.lines * 0.8),
						},
					})
				end

				local term = terminals[id]
				local current_tab = vim.api.nvim_get_current_tabpage()
				local term_buf = term.bufnr
				local term_win_id = nil
				local term_tab_id = nil

				-- 1. Locate the terminal window anywhere in Neovim
				if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
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

				-- 2. If it's NOT open anywhere: Open fresh in target direction
				if not term_win_id then
					term.direction = target_direction
					term:open()
					vim.cmd("startinsert")
					return
				end

				-- 3. If it IS open: Evaluate if we close it or move/transform it
				local win_config = vim.api.nvim_win_get_config(term_win_id)
				local is_currently_float = (win_config.relative ~= "")
				local want_float = (target_direction == "float")

				if term_tab_id == current_tab and is_currently_float == want_float then
					-- Case: Same tab AND same shape -> Close it
					term:close()
				else
					-- Case: Different tab OR Different shape -> Move/Transform it here
					-- Use the "remote kill" method to avoid tab jumping
					if vim.api.nvim_win_is_valid(term_win_id) then
						vim.api.nvim_win_close(term_win_id, true)
					end

					term.window = nil
					term.direction = target_direction
					term:open()
					vim.schedule(function()
						vim.cmd("startinsert")
					end)
				end
			end

			return {
				{
					"<F5>",
					function()
						smart_toggle("horizontal", 1)
					end,
					mode = { "n", "t", "v", "i" },
					desc = "Terminal: Bottom (Open/Move/Close)",
				},
				{
					"<F6>",
					function()
						smart_toggle("float", 1)
					end,
					mode = { "n", "t", "v", "i" },
					desc = "Terminal: Float (Open/Move/Close)",
				},
				{
					"<F7>",
					function()
						smart_toggle("horizontal", 2)
					end,
					mode = { "n", "t", "v", "i" },
					desc = "Terminal2: Bottom (Open/Move/Close)",
				},
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
