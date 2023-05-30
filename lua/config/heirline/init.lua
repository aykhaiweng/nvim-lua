local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local c = require("config/heirline/consts")

-- invoke colors
require("config/heirline/colors").setup_colors()

-- components
local vimode = require("config/heirline/components/vimode")
local files = require("config/heirline/components/files")
local git = require("config/heirline/components/git")

-- vim options
vim.cmd "set noshowmode"
vim.cmd "set showcmd"
vim.o.showtabline = 1
vim.o.laststatus = 3
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- Blocks
local ViModeBlock = utils.surround({ c.empty, c.empty }, function(self) return self:mode_color() end, {vimode, hl = { fg = 'black'} } )
local FileNameBlock = utils.surround({ " ", " " }, nil, files.FileNameBlock)
local GitBlock = utils.surround({ " ", " " }, nil, git)

-- statusline
local StatusLine = {
    static = {
        mode_colors_map = {
            n = "red",
            i = "green",
            v = "cyan",
            V = "cyan",
            ["\22"] = "cyan",
            c = "orange",
            s = "purple",
            S = "purple",
            ["\19"] = "purple",
            R = "orange",
            r = "orange",
            ["!"] = "red",
            t = "green",
        },
        mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            return self.mode_colors_map[mode]
        end,
    },
    ViModeBlock,
    FileNameBlock,
    GitBlock
}

-- invoke layout
require("heirline").setup({
    statusline = StatusLine
})
