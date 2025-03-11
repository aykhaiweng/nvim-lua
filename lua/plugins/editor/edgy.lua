return {
	-- {
	-- 	"lucobellic/edgy-group.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = { "folke/edgy.nvim" },
	-- 	keys = {
	-- 		{
	-- 			"<leader>wh",
	-- 			function()
	-- 				require("edgy-group").open_group_offset("left", 1)
	-- 			end,
	-- 			desc = "Edgy Group Next Left",
	-- 		},
	-- 		{
	-- 			"<leader>wl",
	-- 			function()
	-- 				require("edgy-group").open_group_offset("left", -1)
	-- 			end,
	-- 			desc = "Edgy Group Prev Left",
	-- 		},
	-- 		{
	-- 			"<c-,>",
	-- 			function()
	-- 				require("edgy-group.stl").pick()
	-- 			end,
	-- 			desc = "Edgy Group Pick",
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		groups = {
	-- 			left = {
	-- 				{ icon = "", titles = { "Neo-Tree" } },
	-- 				{ icon = "", titles = { "Neo-Tree Git" } },
	-- 				{ icon = "", titles = { "Outline" } },
	-- 			},
	-- 		},
	-- 		statusline = {
	-- 			separators = { " ", " " },
	-- 			clickable = true,
	-- 			colored = true,
	-- 			colors = {
	-- 				active = "PmenuSel",
	-- 				inactive = "Pmenu",
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"folke/edgy.nvim",
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>ww",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
			{
				"<C-b>",
				function()
					require("edgy").toggle()
				end,
				desc = "Edgy Toggle",
			},
            -- stylua: ignore
            {
                "<leader>wE",
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
						size = 50,
					},
					right = {
						size = 50,
					},
					bottom = {
						size = 20,
					},
				},
				left = {
					{
						title = "Neo-Tree Git",
						ft = "neo-tree",
						pinned = false,
                        filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
						open = "Neotree position=top git_status",
						size = { height = 0.3 },
					},
					{
						title = "Neo-Tree Files",
						ft = "neo-tree",
						pinned = true,
                        filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
						open = "Neotree position=left filesystem",
						size = { height = 0.5 },
					},
					-- {
					-- 	title = "Outline",
					-- 	ft = "Outline",
					-- 	pinned = true,
					-- 	open = function()
					-- 		vim.cmd("OutlineOpen")
					-- 	end,
					-- 	size = { height = 0.5 },
					-- },
				},
				right = {
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
				bottom = {
					"qf",
					"loclist",
					"fugitive",
					"NeogitStatus",
					"help",
				},
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
