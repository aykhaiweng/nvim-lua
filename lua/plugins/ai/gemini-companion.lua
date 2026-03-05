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
					local panes = vim.fn.system("tmux list-panes -t : -F '#{pane_id} #{pane_start_command}'")
					local target_pane = nil
					for line in panes:gmatch("[^\r\n]+") do
						local id, start_cmd = line:match("^(%%?%d+)%s+(.*)$")
						if start_cmd and start_cmd:find("gemini") then
							target_pane = id
							break
						end
					end

					if target_pane then
						-- If the pane exists, sync the port and show the pane
						local sync_cmd = string.format(
							"export GEMINI_CLI_IDE_SERVER_PORT=%d\n",
							status.port
						)
						vim.fn.system(string.format("tmux send-keys -t %s %s", target_pane, vim.fn.shellescape(sync_cmd)))
						os.execute("tmux select-pane -t " .. target_pane)
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
