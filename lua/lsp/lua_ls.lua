return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
			},
			-- Still keep globals "vim" just in case lazydev isn't active
			diagnostics = { globals = { "vim" } },
			telemetry = { enabled = false },
		},
	},
}
