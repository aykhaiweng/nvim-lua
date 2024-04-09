return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
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
                    enable = true
                },
                highlight_diagnostics = "name",
                highlight_git = "name",
            },
		})

		vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Open file explorer" })
		vim.keymap.set("n", "<leader>-", ":NvimTreeFindFile<CR>", { desc = "Focus current file in explorer" })
	end,
}
