return {
	{
		"ahmedkhalf/project.nvim",
		version = "*",
		lazy = false,
        enabled = false,
		opts = {
			patterns = {
                ".git",
                "_darcs",
                ".hg",
                ".bzr",
                ".svn",
                "Makefile",
                "package.json",
                "pyproject.toml",
                "docker-compose.yaml",
                "Dockerfile",
                "requirements.txt",
                "Pipfile",
            },
		},
		config = function(_, opts)
			require("project_nvim").setup(opts)
			require("telescope").load_extension("projects")
			-- nvim-tree patch
			require("nvim-tree").setup({
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})
		end,
	},
}
