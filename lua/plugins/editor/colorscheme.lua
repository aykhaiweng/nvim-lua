return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 9999,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = true,
					shade = "dark",
					percentage = 0.50,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = {},
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_higlights = {},
				highlight_overrides = {
					mocha = function(c)
						return {
							Cursor = { bg = c.foreground, fg = c.mantle },
							LspSignatureActiveParameter = { bg = c.peach, fg = c.mantle },
							-- Borders
							WinSeparator = { bg = c.mantle, fg = c.mantle },
							-- -- Sign Column
							-- SignColumn = { bg = c.mantle },
							-- SignColumnSB = { bg = c.mantle },
							-- LineNr = { bg = c.mantle },
							-- -- Barbecue
							-- barbecue_normal = { bg = c.mantle },
							-- -- Trouble
							-- TroubleNormal = { bg = c.mantle },
							-- -- Indent Scope
							-- MiniIndentscopeSymbol = { fg = c.flamingo },
							-- -- Outline
							-- OutlineNormal = { bg = c.mantle }
						}
					end,
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					treesitter = true,
					lsp_trouble = true,
					symbols_outline = true,
					illuminate = true,
					dropbar = {
						enabled = true,
						color_mode = true, -- enable color for kind's texts, not just kind's icons
					},
					indent_blankline = {
						enabled = true,
						scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = true,
					},
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					barbecue = {
						dim_dirname = true, -- directory name is dimmed by default
						bold_basename = false,
						dim_context = true,
						alt_background = true,
					},
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")

			-- Darken the Normal color
			-- flavour = require("catppuccin").flavour
			-- C = require("catppuccin.palettes").get_palette(flavour)
			-- U = require("catppuccin.utils.colors")
			-- local darken_percentage = 0.20
			-- C.dim = U.vary_color(
			--     { latte = U.darken(C.base, darken_percentage, C.mantle) },
			--     U.darken(C.base, darken_percentage, C.mantle)
			-- )

			-- local DimmedBackground = vim.api.nvim_create_augroup(
			--     "DimmedBackground", { clear = true }
			-- )
			-- vim.api.nvim_create_autocmd({"BufEnter"},
			--     {
			--         pattern = "*",
			--         callback = function(ev)
			--             local buftype = vim.bo.buftype
			--             print(buftype)
			--             if buftype == "help" or buftype == "nowrite" then
			--                 -- vim.api.nvim_set_hl(0, "Normal", { bg=C.dim })
			--             end
			--         end,
			--         group = DimmedBackground
			--     }
			-- )

			-- changing the cursor
			vim.cmd([[ set guicursor=n-v-c:block-Cursor ]])
			vim.cmd([[ set guicursor+=i-ci-ve:ver25 ]])
			vim.cmd([[ set guicursor+=r-cr:block-Cursor ]])
			vim.cmd([[ set guicursor+=a:blinkwait75-blinkoff400-blinkon200 ]])
		end,
	},
}
