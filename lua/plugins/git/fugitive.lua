return {
	{
		"tpope/vim-fugitive",
		keys = function()
			return {
				{ "<leader>gg", [[:<C-U>Git<CR>]], "n", desc = "Fugitive" },
				-- { "<leader>gm", [[:<C-U>Git mergetool<CR>]], "n", { desc = "Fugitive" } },
				-- { "<leader>gd", [[:<C-U>Git difftool<CR>]], "n", { desc = "Fugitive" } },
				{ "<leader>gb", [[:<C-U>Git blame<CR>]], "n", desc = "Git blame" },
				{ "<leader>gl", [[:<C-U>Git log<CR>]], "n", desc = "Git log" },
				{ "<leader>pc", [[:<C-U>Telescope git_commits<CR>]], "n", desc = "Git commits" },
				{ "<leader>ps", [[:<C-U>Telescope git_stash<CR>]], "n", desc = "Git stash" },
				{ "<leader>pb", [[:<C-U>Telescope git_branches<CR>]], "n", desc = "Git branches" },
			}
		end,
	},
}
