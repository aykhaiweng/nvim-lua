return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<C-b>", ":NvimTreeToggle<CR>", "n", { desc = "Open file explorer" } },
        { "<leader>-", ":NvimTreeFindFile<CR>", "n", { desc = "Focus current file in explorer" } },
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup({
			view = {
				centralize_selection = true,
				width = {
					min = 30,
					max = 45,
				},
				signcolumn = "no",
			},
			renderer = {
				indent_width = 4,
				indent_markers = {
					enable = true,
				},
				highlight_diagnostics = "name",
				highlight_git = "name",
			},
			filters = {
				enable = false,
			},
		})
	end,
}
