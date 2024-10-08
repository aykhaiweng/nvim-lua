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
    { import = "plugins.colorscheme" },
    { import = "plugins.terminal" },
    { import = "plugins.treesitter" },
    { import = "plugins.ui" },
    { import = "plugins.navigation" },
    { import = "plugins.editor" },
    { import = "plugins.linting" },
    { import = "plugins.formatting" },
    { import = "plugins.dev" },
    { import = "plugins.dev.python" },
}, {
    checker = {
        enabled = true,
    },
    change_detection = {
        enabled = true,
        notify = true,
    },
})
