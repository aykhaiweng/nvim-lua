--[[

Neovim init file
Maintainer: aykhaiweng

--]]
vim.g.mapleader = " "

-- Core init
require("core/options")
require("core/keymaps")
require("core/colors")
require("core/gui")
require("lazy_init")
