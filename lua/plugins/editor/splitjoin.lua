return {
	{
		"Wansmer/treesj",
        enabled = true,
		version = "*",
        cmd = { "TSJToggle" },
        keys = {
            { "<leader>ej", "<cmd>TSJToggle<CR>", "Toggle Splitjoin" },
        },
        opts = {
        },
		config = function(_, opts)
			require("treesj").setup(opts)
		end,
	},
}
