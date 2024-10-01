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
					"<leader>bp",
					function()
						dap.toggle_breakpoint()
					end,
					desc = "Toggle Breakpoint",
				},
				{
					"<leader>bc",
					function()
						dap.continue()
					end,
					desc = "Toggle Breakpoint",
				},
			}
		end,
		config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
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
		end,
	},
}
