return {
	cmd = { "basedpyright" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace", -- Options: "openFilesOnly", "workspace"
			},
			disableOrganizeImports = true,
			reportMissingImports = "error",
			typeCheckingMode = "off",
		},
	},
}
