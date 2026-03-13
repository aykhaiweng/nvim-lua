return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				build = ":MasonUpdate",
				opts = {},
				config = function(_, opts)
					require("mason").setup(opts)
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = { "basedpyright", "lua_ls" },
				},
				config = function(_, opts)
					local lspconfig = require("lspconfig")
					local blink = require("blink.cmp")

					require("mason-lspconfig").setup({
						ensure_installed = opts.ensure_installed,
						handlers = {
							function(server_name)
								local server_config = {}

								-- Try to load server-specific config from lua/lsp/
								local has_custom_config, custom_config = pcall(require, "lsp." .. server_name)
								if has_custom_config then
									server_config = custom_config
								end

								-- Add default capabilities
								local capabilities = vim.lsp.protocol.make_client_capabilities()
								capabilities.textDocument.foldingRange = {
									dynamicRegistration = false,
									lineFoldingOnly = true,
								}
								server_config.capabilities = vim.tbl_deep_extend("force", capabilities, server_config.capabilities or {})

								-- Add blink.cmp capabilities
								server_config.capabilities = blink.get_lsp_capabilities(server_config.capabilities)

								-- Setup the server
								lspconfig[server_name].setup(server_config)
							end,
						},
					})
				end,
			},
		},
		cmd = {
			"LspInfo",
			"LspInstall",
			"LspStart",
		},
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			inlay_hints = {
				enabled = true,
			},
		},
		config = function(_, opts)
			-- Neovim 0.11+ default config for all servers
			if vim.lsp.config then
				vim.lsp.config("*", opts)
			end

			--- diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,
				underline = true,
				update_in_insert = false,
				float = {
					show_header = true,
					border = "rounded",
					focusable = true,
				},
			})

			--- Keybindings for LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local _opts = { buffer = event.buf }

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server
					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", _opts)
					vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<cr>', _opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", _opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", _opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", _opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", _opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", _opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", _opts)
					vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", _opts)
					vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", _opts)
				end,
			})

			--- Automatically open diagnostics on cursor hold
			function OpenDiagnosticIfNoFloat()
				for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
					if vim.api.nvim_win_get_config(winid).zindex then
						return
					end
				end
				-- THIS IS FOR BUILTIN LSP
				vim.diagnostic.open_float({
					scope = "cursor",
					focusable = false,
					close_events = {
						"CursorMoved",
						"CursorMovedI",
						"BufHidden",
						"InsertCharPre",
						"ModeChanged",
						"WinLeave",
					},
				})
			end
			-- Show diagnostics under the cursor when holding position
			vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold" }, {
				pattern = "*",
				callback = function()
					if vim.fn.mode() == "n" then
						OpenDiagnosticIfNoFloat()
					end
				end,
				group = "lsp_diagnostics_hold",
			})
		end,
	},
}
