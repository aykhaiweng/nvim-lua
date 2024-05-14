return {
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
		ft = {
			"python",
		},
		opts = {
			-- Your options go here
			-- name = "venv",
			-- auto_refresh = false
		},
		event = { "VeryLazy" },
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			{ "<leader>vs", "<cmd>VenvSelect<cr>", "Python virtualenv select" },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			{ "<leader>vc", "<cmd>VenvSelectCached<cr>", "Python virtualenv select cached" },
		},
		config = function(_, opts)
            require("venv-selector").setup(opts)
			vim.api.nvim_create_autocmd("BufReadPre", {
				desc = "Auto select virtualenv nvim open",
				pattern = "*",
				callback = function()
					local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
					if venv ~= "" then
						require("venv-selector").retrieve_from_cache()
					end
				end,
				once = true,
			})
		end,
	},
}
