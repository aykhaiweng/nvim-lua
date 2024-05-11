--[[

Neovim init file
Maintainer: aykhaiweng

--]]
vim.g.mapleader = " "

-- Core init
require("core/options")
require("core/keymaps")
require("core/colors")
require("lazy_init")

-- Neovide shit
if vim.g.neovide then
    require("core/neovide")
end
