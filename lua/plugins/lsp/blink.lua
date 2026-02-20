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
	-- ["<esc>"] = { "fallback" },
}

return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "*",
	enabled = true,
	opts = {
		keymap = custom_keymaps,
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
			--
			list = {
				selection = {
					auto_insert = false,
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
			documentation = {
				-- Controls whether the documentation window will automatically show when selecting a completion item
				auto_show = true,
				-- Delay before showing the documentation window
				auto_show_delay_ms = 500,
				-- Delay before updating the documentation window when selecting a new item,
				-- while an existing item is still visible
				update_delay_ms = 50,
				-- Whether to use treesitter highlighting, disable if you run into performance issues
				-- treesitter_highlighting = true,
				-- -- Draws the item in the documentation window, by default using an internal treessitter based implementation
				draw = function(opts)
					opts.default_implementation()
				end,
				window = {
					min_width = 10,
					max_width = 80,
					max_height = 20,
					border = "padded",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					-- Note that the gutter will be disabled when border ~= 'none'
					scrollbar = true,
					-- Which directions to show the documentation window,
					-- for each of the possible menu window directions,
					-- falling back to the next direction when there's not enough space
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},

			-- Display a preview of the selected item on the current line
			-- ghost_text = {
			-- 	enabled = false,
			-- 	-- Show the ghost text when an item has been selected
			-- 	show_with_selection = true,
			-- 	-- Show the ghost text when no item has been selected, defaulting to the first item
			-- 	show_without_selection = false,
			-- 	-- Show the ghost text when the menu is open
			-- 	show_with_menu = true,
			-- 	-- Show the ghost text when the menu is closed
			-- 	show_without_menu = true,
			-- },
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

		--- Disable blink when in gitcommit
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

		-- vim.cmd("set completeopt=noselect")
		vim.o.winborder = "rounded"
	end,
}
