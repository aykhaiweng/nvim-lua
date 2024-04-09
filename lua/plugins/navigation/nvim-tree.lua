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

        })

        vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", {desc = "Open file explorer"})
        vim.keymap.set("n", "<leader>-", ":NvimTreeFindFile<CR>", {desc = "Focus current file in explorer"})
	end,
}
