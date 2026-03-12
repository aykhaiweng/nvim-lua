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
			highlight_overrides = {
				mocha = function(mocha)
					return {
						Folded = { bg = "" },  -- remove the backgrounds from folds
					}
				end,
			},
			transparent_background = false, -- disables setting the background color.
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark", -- string
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
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
				ufo = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				navic = {
					enabled = true,
					custom_bg = "#181825",
				},
				snacks = true,
				harpoon = true,
				neogit = true,
				noice = true,
				treesitter_context = true,
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
