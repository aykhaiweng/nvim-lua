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
			local _cmd = string.format('tmuxattach _floaters %s zsh "source-file $HOME/.tmux-popup.conf"', _cwd)
			local _projectTerminal = Terminal:new({
				cmd = _cmd,
				hidden = true,
                size = 20,
			})
			function ProjectTerminal_toggle()
				_projectTerminal:toggle()
			end

			return {
				{
					"<F5>",
					"<cmd>lua ProjectTerminal_toggle()<cr>",
					mode = { "n", "i", "t" },
					desc = "Toggle Project Terminal",
				},
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
