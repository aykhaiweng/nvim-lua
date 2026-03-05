return {
	"gutsavgupta/nvim-gemini-companion",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		require("gemini").setup()
	end,
	keys = {
		-- { "<leader>ai", "<cmd>GeminiToggle<cr>", desc = "Toggle Gemini sidebar" },
		{
			"<leader>as",
			function()
				local gemini = require("gemini")
				local status = gemini.getServerStatus()
				if not status.port then
					vim.cmd("GeminiSwitchToCli sidebar gemini")
					return
				end

				if os.getenv("TMUX") then
					local panes = vim.fn.system("tmux list-panes -t : -F '#{pane_start_command}'")
					if panes:find("gemini") then
						os.execute("tmux resize-pane -Z")
					else
						local env_cmd = string.format(
							'TERM_PROGRAM="vscode" GEMINI_CLI_IDE_WORKSPACE_PATH=%s GEMINI_CLI_IDE_SERVER_PORT=%d ',
							vim.fn.shellescape(status.workspace),
							status.port
						)
						local cmd = "tmux split-window -h -l 80 " .. vim.fn.shellescape(env_cmd .. "gemini")
						os.execute(cmd)
					end
				else
					vim.cmd("GeminiSwitchToCli sidebar gemini")
				end
			end,
			desc = "Spawn or switch to AI session (tmux split)",
		},
		{ "<leader>aS", "<cmd>GeminiSend<cr>", mode = { "x" }, desc = "Send selection to Gemini" },
	},
}
