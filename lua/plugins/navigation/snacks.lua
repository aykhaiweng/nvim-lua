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
			exclude = utils.get_project_excludes({ "picker" }),
		},
		grep = {
			hidden = true,
			ignored = true,
			exclude = utils.get_project_excludes({ "grep" }),
		},
	},
}

--- INDENT
local indent_opts = {
	enabled = true,
	hl = "NormalNC",
	animate = {
		enabled = false,
	},
	scope = {
		enabled = false,
		only_current = true,
	},
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		return {
			picker = picker_opts,
			explorer = {
				enabled = false,
				replace_netrw = false,
			},
			terminal = { enabled = true },
			-- We'll enable other modules as we go
			lazygit = { configure = true },
			indent = indent_opts,
			input = { enabled = true },
			notifier = { enabled = false }, -- Enabled notifier
			scope = { enabled = true },
			words = { enabled = true },
			scroll = { enabled = false }, -- Added smooth scrolling
			win = { enabled = true }, -- Enabled win module for breadcrumbs
		}
	end,
	config = function(_, opts)
		require("snacks").setup(opts)

		-- Show breadcrumbs in the winbar
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	callback = function(args)
		-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 		if client and client.server_capabilities.documentSymbolProvider then
		-- 			vim.opt_local.winbar = "%{%v:lua.Snacks.win.breadcrumbs()%}"
		-- 		end
		-- 	end,
		-- })
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
		-- lazygit
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
	},
}
