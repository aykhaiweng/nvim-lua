return {
	{
		"natecraddock/workspaces.nvim",
		version = "*", -- Pin to GitHub releases
		event = { "VeryLazy" },
        enabled = false,
		cmd = {
			"WorkspacesAdd",
			"WorkspacesAddDir",
			"WorkspacesRemove",
			"WorkspacesRemoveDir",
			"WorkspacesRename",
			"WorkspacesList",
			"WorkspacesListDirs",
			"WorkspacesOpen",
			"WorkspacesSyncDirs",
		},
		config = function(_, opts)
            require("workspaces").setup(opts)
			require("telescope").load_extension("workspaces")
		end,
	},
}
