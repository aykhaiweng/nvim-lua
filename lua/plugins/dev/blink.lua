return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
    version = "*",
	opts = {
		keymap = {
			["<C-space>"] = { "show", "hide", "fallback" },
			["<C-e>"] = { "select_and_accept", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-n>"] = { "show", "select_next", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "show_documentation", "scroll_documentation_down", "fallback" },
			["<C-l>"] = { "show_signature", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
            -- ["<esc>"] = { "cancel", "fallback" },
		},
		appearance = {
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
				selection = {
					preselect = function(ctx)
						return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
					end,
				},
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
			ghost_text = { enabled = true },
		},

        cmdline = {
            enabled = true,
            sources = { "lsp", "path", "buffer" }
        },

		sources = {
			-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
			default = { "lsp", "path", "snippets", "buffer" },
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
