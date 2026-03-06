return {
	"gutsavgupta/nvim-gemini-companion",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	config = function()
		require("gemini").setup()
	end,
	keys = function()
		-- Helper: Find tmux pane by command pattern
		local function find_pane(pattern)
			local panes = vim.fn.system("tmux list-panes -t : -F '#{pane_id} #{pane_start_command}'")
			for line in panes:gmatch("[^\r\n]+") do
				local id, start_cmd = line:match("^(%%?%d+)%s+(.*)$")
				if start_cmd and start_cmd:find(pattern) then
					return id
				end
			end
			return nil
		end

		-- Helper: Get visual selection
		local function get_visual_selection()
			local _, ls, cs = unpack(vim.fn.getpos("v"))
			local _, le, ce = unpack(vim.fn.getpos("."))
			if ls > le or (ls == le and cs > ce) then
				ls, le = le, ls
				cs, ce = ce, cs
			end
			local lines = vim.api.nvim_buf_get_lines(0, ls - 1, le, false)
			if #lines == 0 then
				return ""
			end
			lines[#lines] = string.sub(lines[#lines], 1, ce)
			lines[1] = string.sub(lines[1], cs)
			return table.concat(lines, "\n")
		end

		-- Helper: Spawn or switch to CLI session in tmux
		local function switch_to_cli(cli_name, resume_cmd)
			local gemini = require("gemini")
			local status = gemini.getServerStatus()
			if not status.port then
				vim.cmd("GeminiSwitchToCli sidebar '" .. resume_cmd .. " --resume'")
				return
			end

			if os.getenv("TMUX") then
				local target_pane = find_pane(cli_name)
				if target_pane then
					os.execute("tmux resize-pane -Z")
				else
					local env_cmd = string.format(
						'TERM_PROGRAM="vscode" %s_CLI_IDE_WORKSPACE_PATH=%s %s_CLI_IDE_SERVER_PORT=%d ',
						cli_name:upper(),
						vim.fn.shellescape(status.workspace),
						cli_name:upper(),
						status.port
					)
					local cmd = "tmux split-window -h -l 80 "
						.. vim.fn.shellescape(env_cmd .. resume_cmd .. " --resume")
					os.execute(cmd)
				end
			else
				vim.cmd("GeminiSwitchToCli sidebar '" .. resume_cmd .. " --resume'")
			end
		end

		-- Helper: Send selection to CLI pane
		local function send_to_cli(cli_name)
			local text = get_visual_selection()
			if text == "" then
				return
			end

			if os.getenv("TMUX") then
				local target_pane = find_pane(cli_name)
				if target_pane then
					vim.fn.system("tmux set-buffer " .. vim.fn.shellescape(text))
					vim.fn.system("tmux paste-buffer -p -t " .. target_pane)
					os.execute("tmux select-pane -t " .. target_pane)
					return
				end
			end

			vim.cmd("GeminiSend")
		end

		return {
			-- {
			-- 	"<F7>",
			-- 	function()
			-- 		switch_to_cli("gemini", "gemini")
			-- 	end,
			-- 	desc = "Spawn or switch to Gemini session (tmux split)",
			-- },
			{
				"<F7>",
				function()
					switch_to_cli("qwen", "qwen")
				end,
				desc = "Spawn or switch to Qwen session (tmux split)",
			},
			-- {
			-- 	"<leader>aS",
			-- 	function()
			-- 		send_to_cli("gemini")
			-- 	end,
			-- 	mode = { "x" },
			-- 	desc = "Send selection to Gemini CLI (tmux)",
			-- },
			{
				"<leader>aS",
				function()
					send_to_cli("qwen")
				end,
				mode = { "x" },
				desc = "Send selection to Qwen CLI (tmux)",
			},
		}
	end,
}
