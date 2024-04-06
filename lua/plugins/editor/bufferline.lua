return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
    lazy = false,
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slope",
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "left",
                    separator = true
                }
            },
		},
	},
}
