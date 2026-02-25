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
					-- ensure_installed = {
					-- 	-- bash
					-- 	"shfmt",
					-- 	-- python
					-- 	"basedpyright",
					-- 	"ruff",
					-- 	-- lua
					-- 	"lua_ls",
					-- 	"stylua",
					-- 	-- html/css/js
					-- 	"eslint_d",
					-- 	"prettierd",
					-- 	-- data formats
					-- 	"nginx-config-formatter",
					-- 	"jsonlint",
					-- },
				},
				config = function(_, opts)
					require("mason-lspconfig").setup(opts)
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
			vim.lsp.config("*", opts)

			--- diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = false,
				underline = true,
				update_in_insert = false,
				float = {
					show_header = true,
					border = "rounded",
					focusable = false,
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
