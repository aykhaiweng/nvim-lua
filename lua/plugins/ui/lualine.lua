return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},
		lazy = false,
		init = function()
			-- vim options
			vim.cmd("set noshowmode")
			vim.cmd("set showcmd")
		end,
		opts = function()
			local disabled_filetypes = {
				"help",
				"diff",
				"gitcommit",
				"NvimTree",
				"neo-tree",
				"Outline",
				"undotree",
				"Trouble",
				"fugitive",
				"fugitiveblame",
				"tsplayground",
				"quickfixlist",
				"loclist",
				"qf",
				"noice",
			}
			return {
				options = {
					theme = "catppuccin",
					icons_enabled = true,
					draw_empty = true,
					disabled_filetypes = {
						-- statusline = disabled_filetypes,
						winbar = disabled_filetypes,
					}, -- Commented because using full length bar
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = true,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
					section_separators = "",
					component_separators = "",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							right_padding = 2,
						},
					},
					lualine_b = {
						"branch",
						"diff",
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 80,
						},
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {},
					lualine_y = {
						{
							"encoding",
							"fileformat",
						},
						"filetype",
					},
					lualine_z = {
						"location",
						"progress",
					},
				},
				-- inactive_sections = {
				-- 	lualine_a = {},
				-- 	lualine_b = {},
				-- 	lualine_c = { "filename" },
				-- 	lualine_x = {},
				-- 	lualine_y = {},
				-- 	lualine_z = {},
				-- },
				winbar = {
					lualine_b = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 1,
						},
					},
					lualine_y = {
						{ "diagnostics" },
					},
				},
				inactive_winbar = {
					lualine_a = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 1,
						},
					},
					lualine_y = {
						{ "diagnostics" },
					},
				},
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},
}
