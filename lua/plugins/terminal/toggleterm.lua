return {

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {},
		cmd = {
			"ToggleTerm",
		},
		keys = function()
			local Terminal = require("toggleterm.terminal").Terminal
			local _cwd = vim.fn.getcwd()
			local _cleaned_cwd = string.format("%s-%s", "toggleterm", _cwd)
			local _cmd = string.format("tmux new-session -A -s %s", _cleaned_cwd)
			local _projectTerminal = Terminal:new({
				cmd = _cmd,
				hidden = true,
			})
			function ProjectTerminal_toggle()
				_projectTerminal:toggle()
			end

			return {
				-- {
				-- 	"<F5>",
				-- 	"<cmd>lua ProjectTerminal_toggle()<cr>",
				-- 	mode = { "n", "i", "t" },
				-- 	desc = "Toggle Project Terminal",
				-- },
				-- {
				-- 	"<F6>",
				-- 	"<Cmd>exe v:count1 . 'ToggleTerm'<CR>",
				-- 	mode = { "n", "i", "t" },
				-- 	desc = "Toggle Project Terminal",
				-- },
				-- {
				-- 	"<F7>",
				-- 	"<Cmd>exe v:count1 2 'ToggleTerm'<CR>",
				-- 	mode = { "n", "i", "t" },
				-- 	desc = "Toggle Project Terminal",
				-- },
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
