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
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					-- vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
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
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Config defaults
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local default_setup = function(server)
				require("lspconfig")[server].setup({
					capabilities = lsp_capabilities,
				})
			end

			-- Mason setup
			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
				},
				handlers = {
					default_setup,
				},
			})

			-- Snippets
			-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
			require("luasnip.loaders.from_vscode").lazy_load()
			-- load custom snippets
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
			require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })
			-- Some imba luasnip thing for super tabbing that I do not understand
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- CMP setup
			local cmp = require("cmp")
			cmp.setup({
				completion = {
					completeopt = "menu,menuone,preview,noinsert",
				},
				sources = {
					-- LSP
					{
						name = "nvim_lsp",
						priority = 9,
						option = { use_show_condition = true },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = not context.in_treesitter_capture("string", "comment")
							return show
						end,
					},
					-- Snippets
					{
						name = "luasnip",
						option = { use_show_condition = true },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = not context.in_treesitter_capture("string", "comment", "arguments")
							return show
						end,
					},
					-- Buffer
					{
						name = "buffer",
					},
					-- Path
					{
						name = "path",
						option = { use_show_condition = true },
						trigger_characters = { "*" },
						entry_filter = function(entry, ctx)
							local context = require("cmp.config.context")
							local show = context.in_treesitter_capture("string")
								or context.in_treesitter_capture("comment")
							return show
						end,
					}, -- Show paths in completion
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
						maxwidth = 80,
						ellipsis_char = "...",
					}),
				},
			})

			-- Command Line and Searching shit
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
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

			-- LS setup
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
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
							},
						},
					},
				},
			})
			-- pylsp
			require("lspconfig").pylsp.setup({
				settings = {
					-- configure plugins in pylsp
					pylsp = {
						plugins = {
							pycodestyle = { enabled = false },
							pyflakes = { enabled = false },
							pylint = { enabled = false },
							flake8 = { enabled = false },
							mccabe = { enabled = false },
						},
					},
				},
			})

			vim.opt.pumheight = 20 -- Maximum 10 items in the list
		end,
	},
	-- Signature Help
	{
		"ray-x/lsp_signature.nvim",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			floating_window_above_cur_line = true,
			always_trigger = true,
			toggle_key = "<C-s>",
			hint_enable = false,
			check_completion_visible = false,
			handler_opts = {
				border = "single",
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"lewis6991/hover.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"ldelossa/gh.nvim",
		},
		config = function()
			require("hover").setup({
				init = function()
					-- Require providers
					require("hover.providers.lsp")
					require("hover.providers.gh")
					require("hover.providers.gh_user")
					-- require('hover.providers.jira')
					-- require('hover.providers.man')
					-- require('hover.providers.dictionary')
				end,
				preview_opts = {
					border = "single",
				},
				-- Whether the contents of a currently open hover window should be moved
				-- to a :h preview-window when pressing the hover keymap.
				preview_window = true,
				title = true,
				mouse_providers = {
					"LSP",
				},
			})

			-- Setup keymaps
			vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
			vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
			vim.keymap.set("n", "<S-Tab>", function()
				require("hover").hover_switch("previous")
			end, { desc = "hover.nvim (previous source)" })
			vim.keymap.set("n", "<Tab>", function()
				require("hover").hover_switch("next")
			end, { desc = "hover.nvim (next source)" })

			-- Mouse support
			-- vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
			-- vim.o.mousemoveevent = true
		end,
	},
}
