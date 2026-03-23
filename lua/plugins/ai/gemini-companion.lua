return {
	"gutsavgupta/nvim-gemini-companion",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	enabled = false,
	config = function()
		-- Monkey patch persistence for macOS to fix the /proc dependency
		if vim.loop.os_uname().sysname == "Darwin" then
			local ok_p, persistence = pcall(require, "gemini.persistence")
			if ok_p then
				persistence.isActiveNvimProcess = function(pid)
					local handle = io.popen("ps -p " .. pid .. " -o comm=")
					if not handle then return false end
					local comm = handle:read("*a")
					handle:close()
					return string.find(comm, "nvim") ~= nil
				end
			end
		end
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
			local ok, gemini = pcall(require, "gemini")
			if not ok then return end

			local function get_status()
				local status = gemini.getServerStatus()
				if status and status.port then
					return status
				end
				return nil
			end

			local status = get_status()
			if not status then
				-- Try once more after a short delay if it's just starting up
				vim.wait(200)
				status = get_status()
			end

			if not (status and status.port) then
				-- If no server is running, don't use --resume as there is nothing to resume
				vim.cmd("GeminiSwitchToCli sidebar " .. resume_cmd)
				return
			end

			if os.getenv("TMUX") then
				local target_pane = find_pane(cli_name)
				if target_pane then
					os.execute("tmux resize-pane -Z")
				else
					local workspace = status.workspace or vim.fn.getcwd()
					local env_cmd = string.format(
						'TERM_PROGRAM="vscode" %s_CLI_IDE_WORKSPACE_PATH=%s %s_CLI_IDE_SERVER_PORT=%d ',
						cli_name:upper(),
						vim.fn.shellescape(workspace),
						cli_name:upper(),
						status.port
					)
					local cmd = "tmux split-window -h -l 80 "
						.. vim.fn.shellescape(env_cmd .. resume_cmd)
					os.execute(cmd)
				end
			else
				vim.cmd("GeminiSwitchToCli sidebar " .. resume_cmd)
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
			{
				"<F7>",
				function()
					switch_to_cli("gemini", "gemini")
				end,
				desc = "Spawn or switch to Gemini session (tmux split)",
				mode = {"n", "v", "i", "t", "x"}
			},
			-- {
			-- 	"<F7>",
			-- 	function()
			-- 		switch_to_cli("qwen", "qwen")
			-- 	end,
			-- 	desc = "Spawn or switch to Qwen session (tmux split)",
			-- },
			{
				"<leader>aS",
				function()
					send_to_cli("gemini")
				end,
				mode = { "x" },
				desc = "Send selection to Gemini CLI (tmux)",
			},
			-- {
			-- 	"<leader>aS",
			-- 	function()
			-- 		send_to_cli("qwen")
			-- 	end,
			-- 	mode = { "x" },
			-- 	desc = "Send selection to Qwen CLI (tmux)",
			-- },
		}
	end,
}
