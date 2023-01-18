local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local c = require("config/heirline/consts")
local vimode = require("config/heirline/components/vimode")
local files = require("config/heirline/components/files")
local rulers = require("config/heirline/components/rulers")
local lsp = require("config/heirline/components/lsp")
local diag = require("config/heirline/components/diagnostics")
local git = require("config/heirline/components/git")
local term = require("config/heirline/components/terminal")
local win = require("config/heirline/components/win")
local tabs = require("config/heirline/components/tabs")


--[[

 SECTION: Status Lines

--]]
local ViModeBlock = utils.surround({ c.empty, c.delimiters[2] }, function(self) return self:mode_color() end,
    { c.Space, { hl = { fg = "bg0" }, vimode.ViMode }, c.Space })
local FileNameBlock = utils.surround({ c.empty, c.delimiters[2] }, "bg1", { files.FileNameBlock })
local GitBlock = utils.surround({ c.empty, c.delimiters[2] }, "bg0",
    { condition = function() return conditions.is_git_repo() end, { git.GitName, c.Space, git.GitChanges } })

local RulerBlock = utils.surround({ c.delimiters[1], c.empty }, "bg0", { rulers.Ruler })
local FileTypeBlock = utils.surround({ c.delimiters[1], c.empty }, "bg1", { c.Space, files.FileTypeBlock, c.Space })

local DefaultStatusline = {
    -- left side
    { hl = { bg = "bg1" }, ViModeBlock },
    { hl = { bg = "bg0" }, FileNameBlock },
    GitBlock,
    diag.Diagnostics, c.Space,
    lsp.Navic, c.Space,
    c.Align,
    -- centered
    c.Align,
    -- right side
    lsp.LSPActive, c.Space,
    RulerBlock,
    { hl = { bg = "bg0" }, FileTypeBlock }
}
local InactiveStatusline = {
    -- Status line for inactive windows
    condition = conditions.is_not_active,
    files.FileType, c.Space, files.FileName, c.Align,
}
local SpecialStatusline = {
    -- Status line for Special buffers
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,

    files.FileType, c.Space, files.HelpFileName, c.Align
}
local TerminalStatusline = {
    -- Status line for Terminals
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    -- Quickly add a condition to the ViMode to only show it when buffer is active!
    {
        condition = conditions.is_active,
        { hl = { bg = "bg1" }, ViModeBlock },
        c.Space
    }, files.FileType, c.Space, term.TerminalName, c.Align,
}
M.StatusLine = {
    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
        end
    end,

    static = {
        mode_color_map = c.vimode_colors,
        mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            local color = self.mode_color_map[mode]
            return color
        end,
    },

    -- the first statusline with no condition, or which condition returns true is used.
    -- think of it as a switch case with breaks to stop fallthrough.
    fallthrough = false,

    SpecialStatusline,
    TerminalStatusline,
    InactiveStatusline,
    DefaultStatusline
}


--[[

 SECTION: WinBars

--]]
vim.api.nvim_create_autocmd("User", {
    pattern = 'HeirlineInitWinbar',
    callback = function(args)
        local buf = args.buf
        local buftype = vim.tbl_contains(
            { "prompt", "nofile", "help", "quickfix" },
            vim.bo[buf].buftype
        )
        local filetype = vim.tbl_contains(
            { "gitcommit", "fugitive" },
            vim.bo[buf].filetype
        )
        if buftype or filetype then
            vim.opt_local.winbar = nil
        end
    end,
})
M.WinBars = {
    utils.surround(c.delimiter_chars, "bg0", { win.FileNameBlock, c.Space, win.CloseButton })
}


--[[

  SECTION: Tablines

--]]
M.Tabline = {
    tabs.TabLineOffset, tabs.TabPagesBlock, c.Align, tabs.TabPageClose
}


function M.setup_vim()
    -- vim options
    vim.cmd "set noshowmode"
    vim.cmd "set noshowcmd"
    vim.o.showtabline = 1
    vim.o.laststatus = 3
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
end

return M
