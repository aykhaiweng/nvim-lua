return {
	{
		"linux-cultist/venv-selector.nvim",
        branch = "regexp",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap-python",
		},
        lazy = false,
		ft = {
			"python",
		},
		opts = {
			-- Your options go here
			-- name = "venv",
			-- auto_refresh = false
		},
		keys = {
			-- Keymap to open VenvSelector to pick a venv.
			-- { "<leader>vs", "<cmd>VenvSelect<cr>", "Python virtualenv select" },
			-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
			-- { "<leader>vc", "<cmd>VenvSelectCached<cr>", "Python virtualenv select cached" },
		},
        cmds = {"VenvSelect", "VenvSelectCached"},
		config = function(_, opts)
            require("venv-selector").setup(opts)
		end,
	},
}
