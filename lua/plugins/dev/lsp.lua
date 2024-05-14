local custom_capture = function(capture_func, ...)
	local args = { ... } -- Capture the variable arguments into a table
	for _, arg in ipairs(args) do
		if capture_func(arg) then
			return true
		end
	end
	return false
end

return {
	-- Completion menu
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			-- Keybindings for LSP
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
					-- then check for diagnostics under the cursor
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
		end,
	},
	-- Mason
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = { "williamboman/mason-lspconfig.nvim" },
	},
	-- Snippets
	{
		"L3MON4D3/LuaSnip", -- snippets engine
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippet
		},
	},
	-- Fluff
	{
		"onsails/lspkind.nvim", -- vs-code like pictograms
		event = "InsertEnter",
	},
	-- Git
	{
		"petertriho/cmp-git",
		ft = "gitcommit",
		config = function()
			local cmp = require("cmp")
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "git" },
				}, {
					{ name = "buffer" },
				}),
			})
			require("cmp_git").setup()
		end,
	},
	-- LSP Configurator
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			inlay_hints = {
				enabled = true,
			},
		},
		config = function()
			--- Config defaults
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			lsp_capabilities.semanticTokensProvider = true
			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			--- Snippets
			-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
			require("luasnip.loaders.from_vscode").lazy_load()
			-- load custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
			require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })

			--- Mason setup --- MUST BE BEFORE CMP AND NVIM-LSPCONFIG
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
				},
				handlers = {
					default_setup,
				},
			})

			--- CMP setup
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noinsert",
				},
				border = {
					completion = true,
					documentation = true,
				},
				window = {
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
					},
				},
				sources = {
					-- LSP
					{
						name = "nvim_lsp",
						priority = 9,
						option = { use_show_condition = true },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = not custom_capture(context.in_treesitter_capture, "comment", "string")
							return show
						end,
					},
					-- Snippets
					{
						name = "luasnip",
						option = { use_show_condition = true },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = not custom_capture(
								context.in_treesitter_capture,
								"string",
								"comment",
								"arguments",
								"import_statement",
								"import_from_statement"
							)
							return show
						end,
					},
					-- Buffer
					{
						name = "buffer",
						option = { use_show_condition = true },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = custom_capture(context.in_treesitter_capture, "string", "comment")
							return show
						end,
					},
					-- Path
					{
						name = "path",
						option = { use_show_condition = true },
						trigger_characters = { "/" },
					}, -- Show paths in completion
					{ name = "nvim-lua" },
				},
				mapping = cmp.mapping.preset.insert({
					-- Enter key confirms completion item
					["<C-e>"] = cmp.mapping.confirm({ select = true }),

					-- Ctrl + space triggers completion menu
					["<C-Space>"] = cmp.mapping.complete(),

					-- Doc scrolling
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					-- luasnip stuff
					-- ["<C-f>"] = require("luasnip").jump(1),
					-- ["<C-b>"] = require("luasnip").jump(-1),
					["<C-f>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							require("luasnip").jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-b>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						-- Some imba luasnip thing for super tabbing that I do not understand
						local has_words_before = function()
							unpack = unpack or table.unpack
							local line, col = unpack(vim.api.nvim_win_get_cursor(0))
							return col ~= 0
								and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s")
									== nil
						end
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							require("luasnip").expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							require("luasnip").jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				comparators = {
					cmp.config.compare.kind,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
				},
				-- configure lspkind for vs-code like pictograms in completion menu
				formatting = {
					format = require("lspkind").cmp_format({
						-- mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, item)
							local menu_icon = {
								nvim_lsp = "[LSP]",
								luasnip = "[Luasnip]",
								buffer = "[Buf]",
								path = "[Path]",
							}

							item.menu = menu_icon[entry.source.name]
							return item
						end,
					}),
				},
			})

			--- Diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				update_in_insert = false,
				float = {
					header = "Diagnostics",
					border = "none", -- bordered
					source = true,
					focusable = true,
				},
				severity_sort = true,
			})

			--- Command Line and Searching shit
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				completion = {
					completeopt = "menu,menuone,preview,noselect",
				},
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})

			--- LS setup
			-- lua_ls
			require("lspconfig").lua_ls.setup({
				capabilities = lsp_capabilities,
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
			})
			-- basedpyright
			require("lspconfig").basedpyright.setup({
				settings = {
					basedpyright = {
						typeCheckingMode = "standard",
						reportMissingImports = "error",
						disableOrganizeImports = true,
					},
				},
			})

			vim.opt.pumheight = 0 -- Maximum 10 items in the list
		end,
	},
}
