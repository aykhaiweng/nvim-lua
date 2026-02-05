local servers = {
	lua_ls = {
		settings = {
			Lua = {

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
					library = vim.api.nvim_get_runtime_file("", true),
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
	--- Mason Setup
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup({
		ensure_installed = vim.tbl_keys(servers),
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

			-- diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				virtual_lines = {
					current_line = true,
				},
				underline = true,
				update_in_insert = false,
				float = {
					show_header = true,
					source = "always",
					border = "rounded",
					focusable = false,
				},
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
