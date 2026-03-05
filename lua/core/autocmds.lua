local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("VimResized", {
	desc = "Automatically resize windows when the terminal is resized",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

local focus_dim_group = augroup("FocusDimming", { clear = true })
local original_win_hls = {}

autocmd("FocusLost", {
	group = focus_dim_group,
	callback = function()
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_is_valid(win) and not original_win_hls[win] then
				original_win_hls[win] = vim.api.nvim_win_get_option(win, "winhighlight")
				vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalNC,NormalSB:NormalNC,SignColumn:NormalNC,MsgArea:NormalNC")
			end
		end
	end,
})

autocmd("FocusGained", {
	group = focus_dim_group,
	callback = function()
		for win, hl in pairs(original_win_hls) do
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_set_option(win, "winhighlight", hl)
			end
		end
		original_win_hls = {}
	end,
})
