-- Disable basedpyright capabilities so it only provides diagnostics
-- standard IDE features (hover, completion, etc.) should come from pylsp
return {
	on_attach = function(client, _)
		local capabilities = client.server_capabilities
		capabilities.hoverProvider = false
		capabilities.completionProvider = false
		capabilities.definitionProvider = false
		capabilities.referencesProvider = false
		capabilities.renameProvider = false
		capabilities.signatureHelpProvider = false
		capabilities.documentFormattingProvider = false
		capabilities.documentRangeFormattingProvider = false
	end,
}
