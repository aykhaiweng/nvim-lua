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
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		no_underline = false, -- Force no underline
		styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" }, -- Change the style of comments
			conditionals = { "italic" },
			-- loops = {},
			-- functions = {},
			-- keywords = {},
			-- strings = {},
			-- variables = {},
			-- numbers = {},
			-- booleans = {},
			-- properties = {},
			-- types = {},
			-- operators = {},
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
		},
		highlight_overrides = {
			mocha = function(c)
				-- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
                local darken = require("catppuccin.utils.colors").darken
                local lighten = require("catppuccin.utils.colors").lighten

				local sign_column_background = c.mantle
				local number_column_background = c.mantle
				local primary_bg = c.base
				local sidebar_bg = c.mantle
                local cursor_line = darken(primary_bg, 1.2)
				return {
					--- NATIVE
                    Normal = { bg = primary_bg },
                    NormalNC = { bg = primary_bg },
                    NormalFloat = { bg = sidebar_bg },
                    Cursor = { bg = "blue", fg = primary_bg },
                    CursorLine = { bg = cursor_line },
					-- Borders
					WinSeparator = { bg = sidebar_bg, fg = lighten(sidebar_bg, 0.95) },
					NeoTreeWinSeparator = { bg = sidebar_bg, fg = lighten(sidebar_bg, 0.95) },
					-- LSP Stuff
					LspSignatureActiveParameter = { bg = c.surface0, fg = c.yellow },
					LspInlayHint = { bg = c.crust, style = { "italic" } },
					-- Column Stuff
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
                    lualine_c_normal = { bg = sidebar_bg },
					--- Edgy stuff
					EdgyNormal = { bg = sidebar_bg },
					EdgyTitle = { bg = sidebar_bg, style = { "bold" } },
					EdgyIcon = { bg = sidebar_bg },
					EdgyIconActive = { bg = sidebar_bg },
					EdgyWinBar = { bg = sidebar_bg },
					EdgyWinBarNC = { bg = sidebar_bg },
					--- Neotree
					NeoTreeNormal = { bg = sidebar_bg, },
					NeoTreeNormalNC = { bg = sidebar_bg, },
					--- Outline
					OutlineCurrent = { bg = "#2a2b3c", fg = "#a6e3a1", style = { "italic", "bold" } },
					--- Treesitter
					TreesitterContext = { bg = number_column_background, style = { "bold" } },
					TreesitterContextLineNumber = { bg = number_column_background, style = {} },
					TreesitterContextBottom = { bg = number_column_background, style = { "bold" } },
					TreesitterContextLineNumberBottom = { bg = number_column_background, style = {} },
					--- Telescope
					TelescopeNormal = { bg = sidebar_bg }, -- Generally the backgrounds
					TelescopeBorder = { bg = sidebar_bg, fg = sidebar_bg }, -- All the borders
					TelescopePromptTitle = { bg = c.pink, fg = sidebar_bg },
					TelescopePromptNormal = { bg = c.base },
					TelescopePromptPrefix = { bg = c.base },
					TelescopePromptBorder = { bg = c.base, fg = c.base },
					TelescopeResultsTitle = { bg = c.green, fg = sidebar_bg },
					TelescopePreviewTitle = { bg = c.blue, fg = sidebar_bg },
					TelescopePreviewNormal = { bg = primary_bg },
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
