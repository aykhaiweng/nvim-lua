return {
	on_attach = function(client, bufnr)
		-- Disable semantic tokens if they are messing with highlighting
		client.server_capabilities.semanticTokensProvider = nil
	end,
}
