return {
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle" },
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, "n", { desc = "Toggle Undotree" } },
		},
		config = function() end,
	},
}
