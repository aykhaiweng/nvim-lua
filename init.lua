--[[

Neovim init file
Maintainer: aykhaiweng

--]]
vim.g.mapleader = " "

-- Core init
require("lazy_init")
require("core/options")
require("core/keymaps")
require("core/colors")
