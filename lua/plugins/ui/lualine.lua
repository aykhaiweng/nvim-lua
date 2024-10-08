return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"SmiteshP/nvim-navic",
				opts = {
					lazy_update_context = false,
					highlight = true,
					click = true,
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
			--          local section_separators = { left = '', right = '' }
			-- local alt_section_separators = { left = "", right = "" }
			local section_separators = { left = "", right = "" }
			local alt_section_separators = { left = "", right = "" }
			local sub_section_separators = { left = "", right = "" }
			-- local sub_section_separators = { left = "", right = "" }
			-- local section_separators = { left = '', right = '' }
			return {
				options = {
					icons_enabled = true,
					section_separators = { left = section_separators.right, right = section_separators.left },
					component_separators = { left = sub_section_separators.right, right = sub_section_separators.left },
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
					},
				},
				sections = {
					lualine_a = {
						{
							"mode",
							separator = { right = section_separators.right },
							right_padding = 2,
						},
					},
					lualine_b = {
						{
							function()
								return vim.g.remote_neovim_host and ("Remote: %s"):format(vim.uv.os_gethostname()) or ""
							end,
							padding = { right = 1, left = 1 },
							separator = { left = section_separators.left, right = section_separators.right },
						},
						"branch",
						"diff",
						-- "diagnostics",
					},
					lualine_c = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 80,
							separator = { right = alt_section_separators.right },
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
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = {
						{
							"tabs",
							mode = 0,
							path = 1,
							separator = { right = alt_section_separators.right },
							component_separator = { right = alt_section_separators.right },
						},
					},
				},
				winbar = {
					lualine_a = {
						{
							"filename",
							file_status = true,
							newfile_status = true,
							path = 1,
							shorting_target = 1,
							separator = { right = alt_section_separators.right },
						},
					},
					lualine_b = {
						{
							"diagnostics",
							separator = { right = alt_section_separators.right },
						},
					},
					lualine_c = {
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
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
							shorting_target = 1000,
							separator = { right = alt_section_separators.right },
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
			-- vim.opt.laststatus = 1 -- 3 to span across
			-- vim.opt.showtabline = 2
		end,
	},
}
