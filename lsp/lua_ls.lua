return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				library = {
					vim.fn.stdpath("data") .. "/lazydev/library",
					vim.env.VIMRUNTIME .. "/lua",
				},
				checkThirdParty = false,
			},
			diagnostics = { globals = { "vim" } },
		},
	},
}
