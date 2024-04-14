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
            local cwd = vim.fn.getcwd()
			local _projectTerminal = Terminal:new({
				cmd = "tmux",
				hidden = true,
			})
			function ProjectTerminal_toggle()
				return _projectTerminal:toggle()
			end

			return {
				{ "<F6>", "<cmd>lua ProjectTerminal_toggle()<cr>", { "n", "t" }, desc = "Toggle Project Terminal" },
			}
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},
}
