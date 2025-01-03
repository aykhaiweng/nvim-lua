return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	opts = {
		-- keymaps
		keymap = {
			preset = "default",
			-- show = { "<C-space>" },
			-- hide = {},
			-- accept = { "<C-e>" },
			-- select_prev = { "<Up>", "<C-k>", "<C-p>" },
			-- select_next = { "<Down>", "<C-j>", "<C-n>" },
			-- show_documentation = {},
			-- hide_documentation = {},
			-- scroll_documentation_up = "<C-b>",
			-- scroll_documentation_down = "<C-f>",
			-- snippet_forward = "<Tab>",
			-- snippet_backward = "<S-Tab>",
			["<C-space>"] = { "show", "hide", "fallback" },
			["<C-e>"] = { "accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-n>"] = { "show", "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "show_documentation", "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		completion = {
			-- 'prefix' will fuzzy match on the text before the cursor
			-- 'full' will fuzzy match on the text before *and* after the cursor
			-- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			keyword = { range = "full" },

			-- Disable auto brackets
			-- NOTE: some LSPs may add auto brackets themselves anyway
			accept = { auto_brackets = { enabled = false } },

			-- or set per mode
			list = {
				selection = function(ctx)
					return ctx.mode == "cmdline" and "auto_insert" or "preselect"
				end,
			},

			menu = {
				-- Don't automatically show the completion menu
				auto_show = true,

				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},

			-- Show documentation when selecting a completion item
			documentation = { auto_show = true, auto_show_delay_ms = 500 },

			-- Display a preview of the selected item on the current line
			ghost_text = { enabled = false },
		},

		sources = {
			-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
			default = { "lsp", "path", "snippets", "buffer" },
			-- Disable cmdline completions
			cmdline = { "lsp", "path", "snippets", "buffer" },
		},

		-- Experimental signature help support
		signature = { enabled = true },
	},
	config = function(_, opts)
		local blink = require("blink.cmp")
		blink.setup(opts)

		-- Custom behaviours
		local blink_augroup = vim.api.nvim_create_augroup("blink_custom", { clear = true })
		vim.api.nvim_create_autocmd({
			"InsertLeave",
			"InsertEnter",
		}, {
			group = blink_augroup,
			callback = function()
				if vim.bo.filetype ~= "gitcommit" then
					blink.hide()
				end
			end,
		})

		-- Custom trigger but only for Insert
		vim.keymap.set("i", "<C-n>", blink.show, { desc = "Show completion" })
	end,
}
