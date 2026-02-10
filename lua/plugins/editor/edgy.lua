return {
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<C-b>",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
            -- stylua: ignore
            {
                "<leader>we",
                function()
                    require("edgy").select()
                end,
                desc = "Edgy Select Window",
            },
		},
		opts = function()
			local opts = {
				animate = {
					enabled = false,
				},
				options = {
					left = {
						size = 45,
					},
					right = {
						size = 45,
					},
					bottom = {
						size = 20,
					},
				},
				left = {
					{
						title = "Files",
						ft = "neo-tree",
						pinned = true,
                        filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
						open = "Neotree position=left filesystem",
						size = { height = 0.6 },
					},
					{
						title = "Git",
						ft = "neo-tree",
						pinned = true,
                        filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
						open = "Neotree position=top git_status",
						size = { height = 0.1 },
					},
				},
				right = {
					{
						title = "Outline",
						ft = "Outline",
						pinned = false,
						open = function()
							vim.cmd("OutlineOpen")
						end,
						size = { height = 0.5 },
					},
                },
				bottom = {
					"qf",
					"loclist",
					"fugitive",
					"NeogitStatus",
					"help",
				},
				keys = {
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

            -- vim options
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
	},
}
