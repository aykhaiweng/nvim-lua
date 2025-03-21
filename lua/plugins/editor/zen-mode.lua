return {
	{
		"folke/zen-mode.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>z", vim.cmd.ZenMode, "n", desc = "ZenMode" },
		},
		config = function()
			-- Setup ZenMode
			require("zen-mode").setup({
				window = {
					backdrop = 0.40, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 180, -- width of the Zen window
					height = 1.00, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						signcolumn = "yes", -- disable signcolumn
						-- number = false, -- disable number column
						-- relativenumber = false, -- disable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = true, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
                        laststatus = 3,
					},
					twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
					gitsigns = { enabled = true }, -- disables git signs
					tmux = { enabled = false }, -- disables the tmux statusline
					-- this will change the font size on kitty when in zen mode
					-- to make this work, you need to set the following kitty options:
					-- - allow_remote_control socket-only
					-- - listen_on unix:/tmp/kitty
				},
                integrations = {
                    gitsigns = true,
                    lualine = true
                }
			})
		end,
	},
}
