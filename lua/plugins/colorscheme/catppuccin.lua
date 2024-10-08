return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = { -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false, -- disables setting the background color.
		show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
		term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "light",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
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
		highlight_overrides = {
			mocha = function(c)
				local sign_column_background = c.mantle
				local number_column_background = c.mantle
				return {
					--- NATIVE
					Cursor = { bg = c.foreground, fg = c.mantle },
					-- NormalFloat = { bg = c.mantle },
					-- NormalNC = { bg = c.mantle },
					-- Borders
					WinSeparator = { bg = c.mantle, fg = c.mantle },
					-- LSP Stuff
					LspSignatureActiveParameter = { bg = c.surface0, fg = c.yellow },
					LspInlayHint = { bg = c.crust, style = { "italic" } },
					--- Column Stuff
					-- LineNr
					SignColumn = { bg = sign_column_background },
					SignColumnSB = { bg = sign_column_background },
					CursorLineNr = { bg = number_column_background, fg = c.yellow, style = { "bold" } },
					LineNr = { bg = number_column_background },
					-- GitSigns
					GitSignsAdd = { bg = sign_column_background },
					GitSignsChange = { bg = sign_column_background },
					GitSignsDelete = { bg = sign_column_background },
					-- DiagnosticSign
					DiagnosticSignOK = { bg = sign_column_background },
					DiagnosticSignHint = { bg = sign_column_background },
					DiagnosticSignInfo = { bg = sign_column_background },
					DiagnosticSignWarn = { bg = sign_column_background },
					DiagnosticSignError = { bg = sign_column_background },
					--- PLUGINS
					-- Edgy stuff
					-- EdgyNormal = { bg = c.crust },
					-- Outline
					-- OutlineCurrent = { bg = c.surface0, fg = c.yellow, style = { "italic" } },
					TreesitterContext = { bg = number_column_background, style = { "bold" } },
					TreesitterContextLineNumber = { bg = number_column_background, style = {} },
					TreesitterContextBottom = { bg = number_column_background, style = { "bold" } },
					TreesitterContextLineNumberBottom = { bg = number_column_background, style = {} },
					-- Telescope
					TelescopeNormal = { bg = c.mantle }, -- Generally the backgrounds
					TelescopeBorder = { bg = c.mantle, fg = c.mantle }, -- All the borders
					TelescopePromptTitle = { bg = c.pink, fg = c.mantle },
					TelescopePromptNormal = { bg = c.base },
					TelescopePromptPrefix = { bg = c.base },
					TelescopePromptBorder = { bg = c.base, fg = c.base },
					TelescopeResultsTitle = { bg = c.green, fg = c.mantle },
					TelescopePreviewTitle = { bg = c.blue, fg = c.mantle },
					TelescopePreviewNormal = { bg = c.background },
				}
			end,
		},
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			neotree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			navic = {
				enabled = true,
				custom_bg = "NONE", -- "lualine" will set background to mantle
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
					background = false,
				},
			},
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
