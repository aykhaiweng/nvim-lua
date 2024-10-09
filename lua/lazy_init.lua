-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
		{ import = "plugins.colorscheme" },
		{ import = "plugins.terminal" },
        --- Do you remember ALE? But better
		{ import = "plugins.treesitter" },
        --- UI and Navigation
		{ import = "plugins.navigation" },
		{ import = "plugins.ui" },
		{ import = "plugins.editor" },
        --- Git stuff
		{ import = "plugins.git" },
        --- Linting and Formatting
		{ import = "plugins.linting" },
		{ import = "plugins.formatting" },
        --- Dev stuff like LSP / Navic etc.
		{ import = "plugins.dev" },
		{ import = "plugins.dev.python" },
        --- AI stuff
		{ import = "plugins.ai" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catppuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
    change_detection = { enabled = false }
})
