return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
				middle_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
				right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
				indicator = {
					icon = "▎", -- this should be omitted if indicator style is not 'icon'
					style = "underline",
				},
				separator_style = "slant",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
}
