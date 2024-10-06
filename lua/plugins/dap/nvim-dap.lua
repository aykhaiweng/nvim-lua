return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		keys = function()
			local dap = require("dap")
			return {
				{
					"<leader>dp",
					mode = { "n" },
					function()
						dap.toggle_breakpoint()
					end,
					desc = "DAP Breakpoint",
				},
				{
					"<leader>dl",
					mode = { "n" },
					function()
						dap.list_breakpoints()
					end,
					desc = "DAP Breakpoint List",
				},
				{
					"<leader>dc",
					mode = { "n" },
					function()
						dap.continue()
					end,
					desc = "DAP Continue",
				},
				{
					"<leader>d]",
					mode = { "n" },
					function()
						dap.step_over()
					end,
					desc = "DAP Step Over",
				},
				{
					"<leader>d[",
					mode = { "n" },
					function()
						dap.step_back()
					end,
					desc = "DAP Step Back",
				},
			}
		end,
		config = function(_, opts)
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			local set_namespace = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns
			local namespace = vim.api.nvim_create_namespace("dap-hlng")
			vim.api.nvim_set_hl(namespace, "DapBreakpoint", { fg = "#eaeaeb", bg = "#ffffff" })
			vim.api.nvim_set_hl(namespace, "DapLogPoint", { fg = "#eaeaeb", bg = "#ffffff" })
			vim.api.nvim_set_hl(namespace, "DapStopped", { fg = "#eaeaeb", bg = "#ffffff" })

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
			)
		end,
	},
}
