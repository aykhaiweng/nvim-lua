return {
	cmd = { "basedpyright" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			typeCheckingMode = "off",
			reportMissingImports = "error",
			disableOrganizeImports = true,
		},
	},
}
