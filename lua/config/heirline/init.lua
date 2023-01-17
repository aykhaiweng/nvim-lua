local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local layouts = require("config/heirline/layouts")

-- invoke colors
require("config/heirline/colors").setup_colors()

-- invoke layout
layouts.default.setup_vim()
require("heirline").setup({
    statusline = layouts.default.StatusLine,
    winbar = layouts.default.WinBars,
})

-- Vim Options
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
