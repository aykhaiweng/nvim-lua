return {
	-- {
	--     'linrongbin16/lsp-progress.nvim',
	--     cmd = { "LspInfo", "LspInstall", "LspStart" },
	--     event = { "BufReadPre", "BufNewFile" },
	--     init = function()
	--         -- listen lsp-progress event and refresh lualine
	--         vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
	--         vim.api.nvim_create_autocmd("User", {
	--             group = "lualine_augroup",
	--             pattern = "LspProgressStatusUpdated",
	--             callback = require("lualine").refresh,
	--         })
	--     end,
	--     config = function()
	--         require('lsp-progress').setup()
	--     end
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		opts = function()
			local disabled_filetypes = {
				"help",
				"term",
				"diff",
				"gitcommit",
				"NvimTree",
				"Outline",
				"undotree",
				"Trouble",
				"fugitive",
				"fugitiveblame",
				"tsplayground",
				"toggleterm",
			}

			local colors = {
				blue = "#80a0ff",
				cyan = "#79dac8",
				black = "#080808",
				white = "#c6c6c6",
				red = "#ff5189",
				violet = "#d183e8",
				grey = "#303030",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.violet },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white },
				},

				insert = { a = { fg = colors.black, bg = colors.blue } },
				visual = { a = { fg = colors.black, bg = colors.cyan } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white },
				},
			}

			return {
				options = {
					icons_enabled = true,
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = disabled_filetypes,
						winbar = disabled_filetypes,
					}, -- Commented because using full length bar
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = {
                        { "mode", separator = { left = "" }, right_padding = 2 },
                    },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = { { "encoding", "fileformat" }, "filetype" },
					lualine_z = {
                        "location",
						{ "progress", separator = { right = "" }, left_padding = 2 },
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)

			-- vim options
			vim.cmd("set noshowmode")
			vim.cmd("set showcmd")
			vim.o.laststatus = 1 -- 3 to span across
		end,
	},
}
