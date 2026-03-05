local terminals = {}

local function smart_toggle(target_direction, id, position)
	-- Use position as part of the key if no specific ID is provided
	local term_id = id or position or 1
	local term = terminals[term_id]

	if not term or not vim.api.nvim_buf_is_valid(term.buf) then
		term = { buf = vim.api.nvim_create_buf(false, true) }
		terminals[term_id] = term
	end

	local current_tab = vim.api.nvim_get_current_tabpage()
	local term_buf = term.buf
	local term_win_id = nil
	local term_tab_id = nil

	-- 1. Locate the terminal window anywhere in Neovim
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

	local function open_term()
		if target_direction == "float" then
			local width = math.floor(vim.o.columns * 0.6)
			local height = math.floor(vim.o.lines * 0.8)
			local col = math.floor((vim.o.columns - width) / 2)
			local row = math.floor((vim.o.lines - height) / 2)
			local win = vim.api.nvim_open_win(term_buf, true, {
				relative = "editor",
				width = width,
				height = height,
				col = col,
				row = row,
				style = "minimal",
				border = "single",
			})
			return win
		else
			-- horizontal
			vim.cmd("botright " .. 20 .. "split")
			vim.api.nvim_win_set_buf(0, term_buf)
			return vim.api.nvim_get_current_win()
		end
	end

	-- 2. If it's NOT open anywhere: Open fresh in target direction
	if not term_win_id then
		open_term()
		if vim.bo[term_buf].buftype ~= "terminal" then
			vim.cmd("terminal")
			vim.bo[term_buf].filetype = "terminal"

			-- Clean up buffer when terminal exits
			vim.api.nvim_create_autocmd("TermClose", {
				buffer = term_buf,
				callback = function()
					if vim.api.nvim_buf_is_valid(term_buf) then
						vim.api.nvim_buf_delete(term_buf, { force = true })
					end
				end,
			})
		end
		vim.b[term_buf].terminal_id = term_id
		vim.b[term_buf].terminal_position = position
		vim.b[term_buf].terminal_direction = target_direction

		vim.cmd("startinsert")
		return
	end

	-- 3. If it IS open: Evaluate if we close it or move/transform it
	local win_config = vim.api.nvim_win_get_config(term_win_id)
	local is_currently_float = (win_config.relative ~= "")
	local want_float = (target_direction == "float")

	if term_tab_id == current_tab and is_currently_float == want_float then
		-- Case: Same tab AND same shape -> Close it
		vim.api.nvim_win_close(term_win_id, true)
	else
		-- Case: Different tab OR Different shape -> Move/Transform it here
		if vim.api.nvim_win_is_valid(term_win_id) then
			vim.api.nvim_win_close(term_win_id, true)
		end
		open_term()
		-- Update state on move
		vim.b[term_buf].terminal_position = position
		vim.b[term_buf].terminal_direction = target_direction
		vim.schedule(function()
			vim.cmd("startinsert")
		end)
	end
end

vim.keymap.set({ "n", "t", "v", "i" }, "<F5>", function()
	smart_toggle("horizontal", 1, "bottom")
end, { desc = "Terminal: Bottom (Open/Move/Close)" })

vim.keymap.set({ "n", "t", "v", "i" }, "<F6>", function()
	smart_toggle("float", 1)
end, { desc = "Terminal: Float (Open/Move/Close)" })

-- vim.keymap.set({ "n", "t", "v", "i" }, "<F7>", function()
-- 	smart_toggle("horizontal", 2, "bottom")
-- end, { desc = "Terminal2: Bottom (Open/Move/Close)" })

local group = vim.api.nvim_create_augroup("NativeTerminal", { clear = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	group = group,
	pattern = "term://*",
	callback = function(args)
		if vim.bo[args.buf].buftype == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

return {}
