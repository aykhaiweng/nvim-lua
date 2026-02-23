return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = function()
		local C = require("catppuccin.palettes").get_palette "mocha"
		local transparent_bg = C.normal
		local _opts = {
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
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
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			default_integrations = true,
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				neotree = true,
				treesitter = true,
				blink_cmp = true,
				notify = true,
				-- lualine = {
				-- 	normal = {
				-- 		a = { bg = C.blue, fg = C.mantle, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.blue },
				-- 		c = { bg = transparent_bg, fg = C.text },
				-- 	},
				-- 	insert = {
				-- 		a = { bg = C.green, fg = C.base, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.green },
				-- 	},
				-- 	terminal = {
				-- 		a = { bg = C.green, fg = C.base, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.green },
				-- 	},
				-- 	command = {
				-- 		a = { bg = C.peach, fg = C.base, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.peach },
				-- 	},
				-- 	visual = {
				-- 		a = { bg = C.mauve, fg = C.base, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.mauve },
				-- 	},
				-- 	replace = {
				-- 		a = { bg = C.red, fg = C.base, gui = "bold" },
				-- 		b = { bg = C.surface0, fg = C.red },
				-- 	},
				-- 	inactive = {
				-- 		a = { bg = transparent_bg, fg = C.blue },
				-- 		b = { bg = transparent_bg, fg = C.surface1, gui = "bold" },
				-- 		c = { bg = transparent_bg, fg = C.overlay0 },
				-- 	},
				-- },
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				navic = {
					enabled = true,
					custom_bg = "#181825",
				},
				harpoon = true,
				neogit = true,
				noice = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		}
		return _opts
	end,
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
