-- Bootstrapping the installation of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Registering the plugins
require("lazy").setup({
	{ import = "plugins" },
	{ import = "plugins.navigation" },
	{ import = "plugins.git" },
	{ import = "plugins.editor" },
	{ import = "plugins.dev" },
	{ import = "plugins.terminal" },
	{ import = "plugins.profiling" },
	{ import = "plugins.lsp" },
	{ import = "plugins.dap" },
}, {
	checker = {
		enabled = true,
	},
	change_detection = {
		enabled = false,
		notify = false,
	},
})
