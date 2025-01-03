return {
	{
		"echasnovski/mini.starter",
		version = "*",
		lazy = false,
		config = function()
			local starter = require("mini.starter")

			local my_items = {
				-- Remote
				-- {
				-- 	section = "Remote",
				-- 	name = "Start remote session",
				-- 	action = [[:RemoteStart]],
				-- },
				-- {
				-- 	section = "Remote",
				-- 	name = "Show remote logs",
				-- 	action = [[:RemoteLog]],
				-- },
				-- {
				-- 	section = "Remote",
				-- 	name = "Show remote info",
				-- 	action = [[:RemoteInfo]],
				-- },
				-- Telescope
				{
					section = "Telescope",
					name = "Find files",
					action = [[lua require("telescope.builtin").find_files()]],
				},
				{
					section = "Telescope",
					name = "Find recent files",
					action = [[lua require("telescope.builtin").oldfiles()]],
				},
				-- Lazy
				{
					section = "Plugin Manager",
					name = "Lazy",
					action = [[:Lazy]],
				},
				{
					section = "Plugin Manager",
					name = "Update",
					action = [[:Lazy update]],
				},
			}

			local items = {
				starter.sections.sessions(5, true),
				starter.sections.recent_files(10, true),
				my_items,
			}

			starter.setup({
				-- Whether to open starter buffer on VimEnter. Not opened if Neovim was
				-- started with intent to show something else.
				autoopen = true,

				-- Whether to evaluate action of single active item
				evaluate_single = false,

				-- Items to be displayed. Should be an array with the following elements:
				-- - Item: table with <action>, <name>, and <section> keys.
				-- - Function: should return one of these three categories.
				-- - Array: elements of these three types (i.e. item, array, function).
				-- If `nil` (default), default items will be used (see |mini.starter|).
				items = items,

				-- Header to be displayed before items. Converted to single string via
				-- `tostring` (use `\n` to display several lines). If function, it is
				-- evaluated first. If `nil` (default), polite greeting will be used.
				header = vim.fn.getcwd(),

				-- Footer to be displayed after items. Converted to single string via
				-- `tostring` (use `\n` to display several lines). If function, it is
				-- evaluated first. If `nil` (default), default usage help will be shown.
				footer = "XXXXXXXXX",

				-- Array  of functions to be applied consecutively to initial content.
				-- Each function should take and return content for 'Starter' buffer (see
				-- |mini.starter| and |MiniStarter.content| for more details).
				content_hooks = nil,

				-- Characters to update query. Each character will have special buffer
				-- mapping overriding your global ones. Be careful to not add `:` as it
				-- allows you to go into command mode.
				query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_-.ABCDEFGHIJKLMNOPQRSTUVWXYZ",

				-- Whether to disable showing non-error feedback
				silent = false,
			})

			vim.api.nvim_create_autocmd({ "FileType" }, { pattern = "starter", command = "set nocursorline" })
		end,
	},
}
