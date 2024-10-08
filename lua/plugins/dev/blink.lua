return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	opts = {
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},
		-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		-- adjusts spacing to ensure icons are aligned
		nerd_font_variant = "mono",

		-- experimental auto-brackets support
		-- accept = { auto_brackets = { enabled = true } }

		-- experimental signature help support
	    trigger = { signature_help = { enabled = true } },

		-- keymaps
		keymap = {
			show = { "<C-space>", "<C-n>" },
			hide = {},
			accept = { "<C-e>" },
			select_prev = { "<Up>", "<C-k>", "<C-p>" },
			select_next = { "<Down>", "<C-j>", "<C-n>" },

			show_documentation = {},
			hide_documentation = {},
			scroll_documentation_up = "<C-b>",
			scroll_documentation_down = "<C-f>",

			snippet_forward = "<Tab>",
			snippet_backward = "<S-Tab>",
		},

        -- windows
		windows = {
			autocomplete = {
				min_width = 30,
				max_width = 60,
				max_height = 30,
				border = "none",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
				-- keep the cursor X lines away from the top/bottom of the window
				scrolloff = 2,
				-- which directions to show the window,
				-- falling back to the next direction when there's not enough space
				direction_priority = { "s", "n" },
				-- Controls how the completion items are rendered on the popup window
				-- 'simple' will render the item's kind icon the left alongside the label
				-- 'reversed' will render the label on the left and the kind icon + name on the right
				-- 'function(blink.cmp.CompletionRenderContext): blink.cmp.Component[]' for custom rendering
				draw = "simple",
			},
			documentation = {
				min_width = 30,
				max_width = 60,
				max_height = 40,
				border = "padded",
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
				-- which directions to show the documentation window,
				-- for each of the possible autocomplete window directions,
				-- falling back to the next direction when there's not enough space
				direction_priority = {
					autocomplete_north = { "e", "w", "n", "s" },
					autocomplete_south = { "e", "w", "s", "n" },
				},
				auto_show = true,
				auto_show_delay_ms = 500,
				update_delay_ms = 100,
			},
			signature_help = {
				min_width = 1,
				max_width = 100,
				max_height = 10,
				border = "padded",
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
			},
		},
	},
}