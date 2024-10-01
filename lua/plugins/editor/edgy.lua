return {
	{
		"folke/edgy.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>we",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
			{
				"<leader>wo",
				function()
					require("edgy").open()
				end,
				desc = "Edgy Open",
			},
            -- stylua: ignore
            { "<leader>wE", function() require("edgy").select() end, desc = "Edgy Select Window" },
		},
		opts = function()
			local opts = {
				animate = {
					enabled = false,
				},
				options = {
					left = {
						size = 40,
					},
					right = {
						size = 40,
					},
					bottom = {
						size = 20,
					},
				},
				left = {
					{
						title = "Undotree",
						ft = "undotree",
						pinned = false,
						size = { height = 0.5 },
					},
					{
						title = "Files",
						ft = "NvimTree",
						pinned = true,
						open = function()
							vim.cmd("NvimTreeFindFile")
						end,
						size = { height = 0.5 },
					},
					{
						title = "Outline",
						ft = "Outline",
						pinned = true,
						open = function()
							vim.cmd("OutlineOpen")
						end,
						size = { height = 0.5 },
					},
				},
				right = {},
				bottom = {},
				keys = {
					-- increase width
					["<c-Right>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<c-Left>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<c-Up>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<c-Down>"] = function(win)
						win:resize("height", -2)
					end,
					-- increase width
					["<M-L>"] = function(win)
						win:resize("width", 2)
					end,
					-- decrease width
					["<M-H>"] = function(win)
						win:resize("width", -2)
					end,
					-- increase height
					["<M-K>"] = function(win)
						win:resize("height", 2)
					end,
					-- decrease height
					["<M-J>"] = function(win)
						win:resize("height", -2)
					end,
				},
			}
			return opts
		end,
		config = function(_, opts)
			require("edgy").setup(opts)

			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
	},
}
