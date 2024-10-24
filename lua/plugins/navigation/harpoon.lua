return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = function()
			local harpoon = require("harpoon")

			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			return {
				{
					"<leader>a",
					function()
						harpoon:list():add()
					end,
					"n",
					desc = "Add to Harpoon",
				},
				{
					"<C-e>",
					function()
						-- toggle_telescope(harpoon:list())
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					"n",
					desc = "Open Harpoon",
				},
			}
		end,
		config = function(_, opts)
			local harpoon = require("harpoon")
			harpoon:setup(opts)
		end,
	},
}
