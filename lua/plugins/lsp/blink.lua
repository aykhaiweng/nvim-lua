local custom_keymaps = {
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
}

return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "*",
	opts = {
		keymap = custom_keymaps,
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = false } },

			list = {
				selection = {
					auto_insert = false,
					preselect = function(ctx)
						-- This is a fix for snippets
						return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
					end,
				},
			},

			menu = {
				auto_show = true,
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind", gap = 1 },
					},
				},
			},

			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				update_delay_ms = 50,
				draw = function(opts)
					opts.default_implementation()
				end,
				window = {
					min_width = 10,
					max_width = 80,
					max_height = 20,
					border = "rounded",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					scrollbar = true,
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},

			--- Display a preview of the selected item on the current line
			ghost_text = {
				enabled = true,
				show_with_selection = true,
				show_without_selection = false,
				show_with_menu = true,
				show_without_menu = true,
			},
		},
		cmdline = {
			enabled = true,
			keymap = custom_keymaps,
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == "/" or type == "?" then
					return { "buffer" }
				end
				-- Commands
				if type == ":" or type == "@" then
					return { "cmdline" }
				end
				return {}
			end,
			completion = {
				trigger = {
					show_on_blocked_trigger_characters = {},
					show_on_x_blocked_trigger_characters = {},
				},
				list = {
					selection = {
						-- When `true`, will automatically select the first item in the completion list
						preselect = true,
						-- When `true`, inserts the completion item automatically when selecting it
						auto_insert = false,
					},
				},
				-- Whether to automatically show the window when new completion items are available
				menu = {
					auto_show = true,
					-- border = "rounded",
				},
				-- Displays a preview of the selected item on the current line
				ghost_text = {
					enabled = true,
				},
			},
		},

		sources = {
			-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
			default = {
				"lsp",
				"path",
				"snippets",
				"buffer",
			},
		},
		signature = {
			enabled = true,
			window = {
				show_documentation = true,
			},
		},
	},
	config = function(_, opts)
		local blink = require("blink.cmp")
		blink.setup(opts)

		local blink_augroup = vim.api.nvim_create_augroup("blink_custom", { clear = true })

		--- Disable blink when in gitcommit
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

		--- Every time we go to normal mode attempt to hide the blink window
		vim.api.nvim_create_autocmd("InsertLeave", {
			group = blink_augroup,
			-- Listens for transitions from any mode (*) to Normal mode (n)
			callback = function()
				-- Attempting to close existing menus
				require("blink.cmp").hide()
			end,
		})

		-- Custom trigger but only for Insert
		vim.keymap.set("i", "<C-n>", blink.show, { desc = "Show completion" })

		-- vim.cmd("set completeopt=noselect")
		vim.o.winborder = "rounded"
	end,
}
