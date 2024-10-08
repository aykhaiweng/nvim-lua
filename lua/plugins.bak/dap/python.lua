return {
	{
		"mfussenegger/nvim-dap-python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		ft = { "python" },
		keys = function()
			local dap = require("dap-python")
			return {
				{
					"<leader>dm",
					mode = { "n" },
					function()
						dap.test_method()
					end,
					desc = "DAP Python test method",
				},
				{
					"<leader>df",
					mode = { "n" },
					function()
						dap.test_class()
					end,
					desc = "DAP Python test class",
				},
				{
					"<leader>ds",
					mode = { "v" },
					function()
						dap.debug_selection()
					end,
					desc = "DAP Python debug selection",
				},
			}
		end,
		config = function(_, opts)
			local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	},
}
