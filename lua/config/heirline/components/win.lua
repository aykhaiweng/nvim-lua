local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local c = require("config/heirline/consts")
local files = require("config/heirline/components/files")
local term = require("config/heirline/components/terminal")


M.CloseButton = {
    -- This close button is for windows / buffers
    condition = function()
        return not vim.bo.modified
    end,
    -- a small performance improvement:
    -- re register the component callback only on layout/buffer changes.
    update = {'WinNew', 'WinClosed', 'BufEnter'},
    {
        provider = "",
        on_click = {
            minwid = function()
                return vim.api.nvim_get_current_win()
            end,
            callback = function(_, minwid)
                vim.api.nvim_win_close(minwid, true)
            end,
            name = "heirline_winbar_close_button"
        },
    },
}
M.FileNameBlock = {
    fallthrough = false,
    { -- Hide the winbar for special buffers
        condition = function()
            return conditions.buffer_matches({
                buftype = { "nofile", "prompt", "help", "quickfix" },
                filetype = { "^git.*", "fugitive" },
            })
        end,
        init = function()
            vim.opt_local.winbar = nil
        end
    },
    { -- An inactive winbar for regular files
        condition = function()
            return not conditions.is_active()
        end,
        {
            hl = { fg = "bg2", force = true }, files.FileNameShortenedBlock
        },
    },
    { -- A special winbar for terminals
        condition = function()
            return conditions.buffer_matches({ buftype = { "terminal" } })
        end,
        {
            files.FileType,
            c.Space,
            term.TerminalName,
        }
    },
    -- A winbar for regular files
    files.FileNameShortenedBlock,
}


return M
