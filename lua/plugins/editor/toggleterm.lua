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
		keys = {
			{
				"<F5>",
				function()
					-- Require the Terminal object from toggleterm
					local Terminal = require("toggleterm.terminal").Terminal

					-- Create a reference to the default terminal (ID 1)
					local main_term = Terminal:new({ id = 1 })

					-- Define our smart toggle function
					local function smart_toggleterm()
						-- 2. Open toggleterm if it's not open completely
						if not main_term:is_open() then
							main_term:open()
							return
						end

						local win = main_term.window

						-- Safety check: ensure the window is valid
						if win and vim.api.nvim_win_is_valid(win) then
							local term_tab = vim.api.nvim_win_get_tabpage(win)
							local current_tab = vim.api.nvim_get_current_tabpage()

							if term_tab == current_tab then
								-- 1. Focus on toggleterm if not in the toggleterm window
								if vim.api.nvim_get_current_win() ~= win then
									vim.api.nvim_set_current_win(win)
									vim.cmd("startinsert") -- Auto-enter insert mode
								else
									-- If we are already focused on it, close/hide it
									main_term:close()
								end
							else
								-- 3. Move toggleterm to the current tab if it's open in another tab
								-- Save our current tab page ID
								local saved_tab = vim.api.nvim_get_current_tabpage()

								-- Close the terminal (which might cause a jump)
								main_term:close()

								-- If Neovim jumped to the old tab, force it back to our saved tab
								if vim.api.nvim_get_current_tabpage() ~= saved_tab then
									vim.api.nvim_set_current_tabpage(saved_tab)
								end

								-- Open the terminal in our current, correct tab
								main_term:open()
							end
						else
							-- Fallback if the window state got detached
							main_term:open()
						end
					end

					smart_toggleterm()
				end,
				mode = { "n", "t", "v", "i" }, -- Normal, Terminal, Insert and Visual modes
				desc = "Toggle/Focus bottom Terminal",
			},
			{
				"<F6>",
				function()
					local Terminal = require("toggleterm.terminal").Terminal

					local float_term = Terminal:new({
						id = 1,
						direction = "float",
						float_opts = {
							border = "curved", -- You can change this to 'single', 'double', 'solid', or 'shadow'
							width = math.floor(vim.o.columns * 0.8), -- Takes up 80% of screen width
							height = math.floor(vim.o.lines * 0.8), -- Takes up 80% of screen height
						},
						-- Automatically enter insert mode when opened
						on_open = function(term)
							vim.cmd("startinsert")
						end,
					})

					-- Define a simple wrapper function to toggle it
					local function toggle_floating_term()
						float_term:toggle()
					end

					toggle_floating_term()
				end,
				mode = { "n", "t", "v", "i" }, -- Normal, Terminal, Insert and Visual modes
				desc = "Open floating Terminal",
			},
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
