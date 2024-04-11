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
						size = 45,
					},
					right = {
						size = 45,
					},
					bottom = {
						size = 25,
					},
				},
				left = {
					{
						title = "Diagnostics",
						ft = "Trouble",
						pinned = true,
						open = function()
							vim.cmd("Trouble")
						end,
						size = { height = 0.3 },
					},
					{
						title = "Files",
						ft = "NvimTree",
						pinned = true,
						open = function()
							vim.cmd("NvimTreeFindFile")
						end,
						size = { height = 0.3 },
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
				right = {
					{
						title = "Fugitive",
						ft = "fugitive",
						pinned = true,
						open = function()
                            vim.cmd("Git")
						end,
						size = { height = 0.5 },
					},
				},
				bottom = {
					"help",
                    "gitcommit"
				},
				keys = {
                    -- next window
                    ["<C-j>"] = function(win)
                        win:next({ visible = true, focus = true })
                    end,
                    -- previous window
                    ["<C-k>"] = function(win)
                        win:prev({ visible = true, focus = true })
                    end,
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
