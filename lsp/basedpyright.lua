---@type vim.lsp.Config
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" },
	-- TODO(skeleton): settings; archive/v1 paired it with pylsp, this runs it alone
}
