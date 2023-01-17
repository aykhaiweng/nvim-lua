local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local c = require("config/heirline/consts")
local colors = require("config/heirline/colors").colors
local vimode = require("config/heirline/components/vimode")
local files = require("config/heirline/components/files")
local rulers = require("config/heirline/components/rulers")
local lsp = require("config/heirline/components/lsp")
local diag = require("config/heirline/components/diagnostics")
local git = require("config/heirline/components/git")
local term = require("config/heirline/components/terminal")
local win = require("config/heirline/components/win")


--[[

 SECTION: Status Lines

--]]
local DefaultStatusline = {
    -- left side
    vimode.ViMode, c.Space,
    files.FileNameBlock, c.Space,
    lsp.Navic, c.Space,
    diag.Diagnostics, c.Space,
    git.GitName, c.Space, git.GitChanges, c.Space,
    c.Align,
    -- centered
    c.Align,
    -- right side
    lsp.LSPActive, c.Space,
    rulers.Ruler, c.Space,
    rulers.ScrollBar, c.Space,
    files.FileTypeBlock
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
        vimode.ViMode,
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
        mode_color_map = colors
    },
    mode_color = function(self)
        local mode = conditions.is_active() and vim.fn.mode() or "n"
        return self.mode_colors_map[mode]
    end,

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


function M.setup_vim()
    -- vim options
    vim.cmd "set noshowmode"
    vim.cmd "set noshowcmd"
    vim.o.showtabline = 1
    vim.o.laststatus = 3
end

return M
