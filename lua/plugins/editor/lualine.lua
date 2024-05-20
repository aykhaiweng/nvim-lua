return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"SmiteshP/nvim-navic",
				opts = {
					lazy_update_context = false,
					lsp = {
						auto_attach = true,
					},
				},
				config = function(_, opts)
					require("nvim-navic").setup(opts)
				end,
			},
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
				"quickfixlist",
				"loclist",
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
						{
							"mode",
							separator = { right = "" },
							right_padding = 2,
						},
					},
					lualine_b = {
						{
							function()
								return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
							end,
							padding = { right = 1, left = 1 },
							separator = { left = "", right = "" },
						},
						"branch",
						"diff",
						"diagnostics",
					},
					lualine_c = {
						"filename",
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
					lualine_y = { { "encoding", "fileformat" }, "filetype" },
					lualine_z = {
						"location",
						{
							"progress",
							left_padding = 2,
						},
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
				tabline = {
					lualine_b = {
						{
							"tabs",
							tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
							max_length = vim.o.columns / 3, -- Maximum width of tabs component.
							-- Note:
							-- It can also be a function that returns
							-- the value of `max_length` dynamically.
							mode = 0, -- 0: Shows tab_nr
							-- 1: Shows tab_name
							-- 2: Shows tab_nr + tab_name

							path = 1, -- 0: just shows the filename
							-- 1: shows the relative path and shorten $HOME to ~
							-- 2: shows the full path
							-- 3: shows the full path and shorten $HOME to ~

							-- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
							use_mode_colors = false,
							show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
							symbols = {
								modified = "[+]", -- Text to show when the file is modified.
							},
						},
					},
					-- lualine_y = { "buffers" },
				},
				winbar = {
					lualine_a = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 60,
							separator = { left = "", right = "" },
						},
					},
					lualine_b = {
						{ "diagnostics" },
					},
					extensions = {},
				},
				inactive_winbar = {
					lualine_a = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
						},
					},
					lualine_b = {
						{ "diagnostics" },
					},
					extensions = {},
				},
			}
		end,
		config = function(_, opts)
			require("lualine").setup(opts)

			-- vim options
			vim.cmd("set noshowmode")
			vim.cmd("set showcmd")
			vim.opt.laststatus = 1 -- 3 to span across
			vim.opt.showtabline = 2
		end,
	},
}
