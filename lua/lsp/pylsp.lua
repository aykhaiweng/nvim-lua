-- Configure pylsp for IDE features while disabling formatters/linters
return {
	on_attach = function(client, _)
		-- Disable formatting provider to ensure it doesn't clash with conform.nvim/ruff
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	settings = {
		pylsp = {
			plugins = {
				-- Formatting (we use ruff via conform)
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				black = { enabled = false },
				-- Linting (we use ruff via nvim-lint or conform)
				pycodestyle = {
					enabled = false,
					ignore = { "E", "W" }, -- Ignore all errors and warnings if it somehow runs
				},
				pyflakes = { enabled = false },
				mccabe = { enabled = false },
				pylint = { enabled = false },
				flake8 = { enabled = false },
				-- Standard features
				jedi_completion = { enabled = true },
				jedi_definition = { enabled = true },
				jedi_hover = { enabled = true },
				jedi_references = { enabled = true },
				jedi_signature_help = { enabled = true },
				jedi_symbols = { enabled = true },
			},
		},
	},
}
