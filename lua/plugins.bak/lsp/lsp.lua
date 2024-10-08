local servers = {
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					autoRequire = true,
				},
				hint = {
					enable = true,
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		},
	},
	basedpyright = {
		settings = {
			basedpyright = {
				typeCheckingMode = "off",
				reportMissingImports = "error",
				disableOrganizeImports = true,
			},
		},
	},
}

local lsp_config = function()
	-- Set up completion using nvim_cmp with LSP source
	local common_capabilities = require("cmp_nvim_lsp").default_capabilities()
	common_capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	local common_on_init = function(client, _)
		-- Disabled due to https://github.com/neovim/neovim/issues/23164
		-- I've been experiencing this annoying issue where there is a slight delay of applying
		-- highlights when opening certain files:
		--  * lua suddenly changes highlights for global variables
		--  * python (pyright and basedpyright) changes highlights and sometimes italicizes import
		--    statements.
		--  I do not want this. Just let treesitter perform the highlighting for now.
		client.server_capabilities.semanticTokensProvider = true
	end

	local common_on_attach_handler = function(client, bufnr)
		if client.server_capabilities.definitionProvider ~= false then
			vim.opt_local.tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		if client.server_capabilities.documentSymbolProvider then
			local has_navic, navic = pcall(require, "nvim-navic")
			if has_navic then
				navic.attach(client, bufnr)
			end
		end
	end

	local common_options = {
		enabled = true,
		on_init = common_on_init,
		on_attach = common_on_attach_handler,
		capabilities = common_capabilities,
		flags = {
			debounce_text_changes = 500, -- 150 seems to be the default by idk what this implies
		},
	}

	--- Mason Setup
	local mason_lspconfig = require("mason-lspconfig")
	local setup_server_handler = function(server_name)
		if servers[server_name] == nil then
			return
		end

		local server_opts = vim.tbl_deep_extend("force", common_options, servers[server_name] or {})

		if server_opts.enabled ~= false then
			require("lspconfig")[server_name].setup(server_opts)
		end
	end

	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
		handlers = { setup_server_handler },
	})

	--- Keybindings for LSP
	vim.api.nvim_create_autocmd("LspAttach", {
		desc = "LSP actions",
		callback = function(event)
			local opts = { buffer = event.buf }

			-- these will be buffer-local keybindings
			-- because they only work if you have an active language server
			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
			vim.keymap.set("n", "gl", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line" })<cr>', opts)
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
			vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
			vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
			vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

			-- Function to check if a floating dialog exists and if not
			-- then check for diagnostics under the cursor, open it
			-- automatically if there is.
			function OpenDiagnosticIfNoFloat()
				for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
					if vim.api.nvim_win_get_config(winid).zindex then
						return
					end
				end
				-- THIS IS FOR BUILTIN LSP
				vim.diagnostic.open_float(0, {
					scope = "cursor",
					focusable = false,
					close_events = {
						"CursorMoved",
						"CursorMovedI",
						"BufHidden",
						"InsertCharPre",
						"WinLeave",
					},
				})
			end
			-- Show diagnostics under the cursor when holding position
			vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
			vim.api.nvim_create_autocmd({ "CursorHold" }, {
				pattern = "*",
				command = "lua OpenDiagnosticIfNoFloat()",
				group = "lsp_diagnostics_hold",
			})
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"SmiteshP/nvim-navic",
			},
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				build = ":MasonUpdate",
				opts = {
					ensure_installed = {
						"prettierd",
						"stylua",
						"eslint_d",
						"jsonlint",
						"djlint",
						"ruff",
					},
				},
				config = function(_, opts)
					require("mason").setup(opts)
					local mr = require("mason-registry")

					local function ensure_installed()
						for _, tool in ipairs(opts.ensure_installed) do
							local p = mr.get_package(tool)
							if not p:is_installed() then
								p:install()
							end
						end
					end

					if mr.refresh() then
						mr.refresh(ensure_installed)
					else
						ensure_installed()
					end
				end,
			},
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			inlay_hints = {
				enabled = true,
			},
		},
		config = lsp_config,
	},
}
