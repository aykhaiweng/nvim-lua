return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		local utils = require("core.utils")
		--- PICKER
		local picker_opts = {
			enabled = true,
			win = {
				input = {
					keys = {
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
			sources = {
				files = {
					hidden = true,
					ignored = true,
					exclude = utils.get_project_excludes({"picker"})
				},
				grep = {
					hidden = true,
					ignored = true,
					exclude = utils.get_project_excludes({"grep"})
				},
			},
			sort = {
				-- Hierarchical sorting: files first, then directories (alphabetically at each level)
				compare = function(a, b)
					local pa = a.file or a.text
					local pb = b.file or b.text
					if not pa or not pb then
						return 0
					end

					local a_parts = vim.split(pa, "/", { trimempty = true })
					local b_parts = vim.split(pb, "/", { trimempty = true })
					local min_len = math.min(#a_parts, #b_parts)

					for i = 1, min_len do
						local apart = a_parts[i]
						local bpart = b_parts[i]

						if apart ~= bpart then
							local a_is_last = (i == #a_parts)
							local b_is_last = (i == #b_parts)

							-- If one is a file at this level and the other is a directory
							if a_is_last and not b_is_last then
								return -1
							elseif not a_is_last and b_is_last then
								return 1
							end

							-- Otherwise, sort alphabetically at this level
							return apart:lower() < bpart:lower() and -1 or 1
						end
					end

					-- If one path is a prefix of the other, shorter one (file) comes first
					if #a_parts ~= #b_parts then
						return #a_parts < #b_parts and -1 or 1
					end
					return 0
				end,
			},
		}

		--- INDENT
		local indent_opts = {
			enabled = true,
		}
		return {
			picker = picker_opts,
			explorer = {
				enabled = false,
				replace_netrw = false,
			},
			terminal = { enabled = true },
			-- We'll enable other modules as we go
			indent = indent_opts,
			input = { enabled = true },
			notifier = { enabled = false },
			scope = { enabled = true },
			words = { enabled = true },
		}
	end,
	keys = {
		-- Find files (C-p and leader pf)
		{
			"<C-p>",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>po",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},

		-- Live Grep (C-f)
		{
			"<C-f>",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<C-f>",
			function()
				-- Get visual selection
				vim.cmd('noau normal! gv"vy')
				local selection = vim.fn.getreg("v")
				Snacks.picker.grep({ search = selection })
			end,
			mode = "v",
			desc = "Grep Visual Selection",
		},
		-- LSP & Diagnostics
		{
			"<leader>pr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "References",
		},
		{
			"<leader>pd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>pk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>ts",
			function()
				Snacks.picker.treesitter()
			end,
			desc = "Treesitter Symbols",
		},
	},
}
