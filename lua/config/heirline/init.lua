local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local layouts = require("config.heirline.layouts")

-- invoke colors
require("config.heirline.colors").setup_colors()

-- invoke layout
-- layouts.old.setup()

-- Vim Options
vim.cmd "set noshowmode"
vim.cmd "set noshowcmd"
vim.o.showtabline = 2
vim.o.laststatus = 3
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
