return {
	-- Completion menu
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
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
					-- vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					-- vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
					-- vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
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
	{
		"L3MON4D3/LuaSnip", -- snippets engine
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippet
		},
	},
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
					{ name = "nvim_lsp", priority = 9 }, -- Show LSP response
					{ name = "luasnip" }, -- Snippets
					{ name = "buffer" }, -- Buffer completions
					{ name = "path" }, -- Show paths in completion
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
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
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
}
