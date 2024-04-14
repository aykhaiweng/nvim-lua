return {
	-- Signature Help
	{
		"ray-x/lsp_signature.nvim",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			floating_window_above_cur_line = false,
			floating_window_off_y = -2,
			-- always_trigger = true,
			hint_enable = false,
			handler_opts = {
				border = "single",
                max_height = 1,
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
