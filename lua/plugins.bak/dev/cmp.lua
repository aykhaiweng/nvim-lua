local custom_capture = function(capture_func, ...)
	local args = { ... } -- Capture the variable arguments into a table
	for _, arg in ipairs(args) do
		if capture_func(arg) then
			return true
		end
	end
	return false
end

local cmp_config = function()
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
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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


    vim.opt.pumheight = 0 -- Maximum 10 items in the list
end

return {
	-- Completion menu
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim", -- vs-code like pictograms
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
		},
		config = cmp_config,
	},
}
