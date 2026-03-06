local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

--- Resize Neovim whenever the pane is resized
autocmd("VimResized", {
	desc = "Automatically resize windows when the terminal is resized",
	callback = function()
		local ok, edgy = pcall(require, "edgy")
		
		-- 1. Ensure all edgy windows have winfix set
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if ok and edgy.get_win(win) then
				vim.wo[win].winfixwidth = true
				vim.wo[win].winfixheight = true
			else
				vim.wo[win].winfixwidth = false
				vim.wo[win].winfixheight = false
			end
		end

		if ok then edgy.fix() end
		vim.cmd("tabdo wincmd =")

		if ok then
			vim.schedule(function()
				if not vim.api.nvim_tabpage_is_valid(0) then return end
				
				edgy.fix()
				vim.cmd("redraw")

				local wins = vim.api.nvim_tabpage_list_wins(0)
				local columns = {}
				for _, win in ipairs(wins) do
					if not edgy.get_win(win) and vim.api.nvim_win_get_config(win).relative == "" then
						local pos = vim.api.nvim_win_get_position(win)
						local x = pos[2]
						columns[x] = columns[x] or {}
						table.insert(columns[x], win)
					end
				end
				for _, column_wins in pairs(columns) do
					if #column_wins > 1 then
						table.sort(column_wins, function(a, b)
							return vim.api.nvim_win_get_position(a)[1] < vim.api.nvim_win_get_position(b)[1]
						end)
						local total_h = 0
						for _, win in ipairs(column_wins) do
							total_h = total_h + vim.api.nvim_win_get_height(win)
						end
						local avg_h = math.floor(total_h / #column_wins)
						local remainder = total_h % #column_wins
						for i, win in ipairs(column_wins) do
							local h = avg_h + (i <= remainder and 1 or 0)
							pcall(vim.api.nvim_win_set_height, win, h)
						end
					end
				end
				edgy.fix()
			end)
		end
	end,
})


--- Dim Neovim when focus is lost
local focus_dim_group = augroup("FocusDimming", { clear = true })
local original_win_hls = {}
autocmd("FocusLost", {
	group = focus_dim_group,
	callback = function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_is_valid(win) and not original_win_hls[win] then
				original_win_hls[win] = vim.api.nvim_get_option_value("winhighlight", { win = win })
				vim.api.nvim_set_option_value(
					"winhighlight",
					"Normal:NormalNC,NormalSB:NormalNC,SignColumn:NormalNC,MsgArea:NormalNC",
					{ win = win }
				)
			end
		end
	end,
})
autocmd("FocusGained", {
	group = focus_dim_group,
	callback = function()
		for win, hl in pairs(original_win_hls) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_set_option_value("winhighlight", hl, { win = win })
			end
		end
		original_win_hls = {}
	end,
})

--- Highlight the cursorline
local CursorLineGroup = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = true
	end,
	group = CursorLineGroup,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = "*",
	callback = function()
		vim.wo.cursorline = false
	end,
	group = CursorLineGroup,
})
