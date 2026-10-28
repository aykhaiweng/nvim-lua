-- Plugin install manifest. vim.pack only installs and pins (nvim-pack-lock.json);
-- lz.n decides when each plugin loads, from the specs in lua/plugins/.
--
-- Every plugin is added with a no-op `load` so vim.pack never sources it:
-- lz.n can't take `keys` through vim.pack's `data` field until
-- neovim/neovim#35550 is fixed, so triggers stay in lz.n specs instead.

local gh = function(repo) return "https://github.com/" .. repo end

-- lz.n itself loads eagerly (default `load` during init.lua is :packadd!).
vim.pack.add({ { src = gh("lumen-oss/lz.n"), version = vim.version.range("3.*") } })

vim.pack.add({
	-- UI
	{ src = gh("catppuccin/nvim"), name = "catppuccin" },
	gh("folke/which-key.nvim"),
	gh("folke/snacks.nvim"), -- picker, explorer, terminal, zen, notifier

	-- Editing
	gh("nvim-treesitter/nvim-treesitter"),
	{ src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") }, -- tags ship the prebuilt fuzzy binary
	gh("folke/flash.nvim"),
	gh("nvim-mini/mini.nvim"), -- ai, surround, hipatterns, statusline, sessions

	-- Tooling
	gh("stevearc/conform.nvim"),
	gh("mfussenegger/nvim-lint"),
	gh("lewis6991/gitsigns.nvim"),
	gh("folke/lazydev.nvim"),

	-- Integration
	gh("smart-splits-nvim/smart-splits.nvim"),
	gh("coder/claudecode.nvim"),
}, { load = function() end })

require("lz.n").load("plugins")
