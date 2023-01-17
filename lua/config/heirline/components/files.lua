local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")


-- Base
M.Base = {
    -- This is to use utils.insert with other files so they have access to
    -- self.filename as well
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}
M.FileNameModifier = {
    hl = function()
        if vim.bo.modified then
            return { fg = "green", bold = true, force = true }
        end
    end,
}


-- Components
M.FileIcon = {
    init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
        return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
        return { fg = self.icon_color }
    end
}
M.FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then return "[No Name]" end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename
    end,
    hl = { fg = utils.get_highlight("Directory").fg },
}
M.FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+]",
        hl = { fg = "green" },
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " ",
        hl = { fg = "orange" },
    },
}
M.HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = "blue" },
}

M.FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true },
}
M.FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
        return enc ~= 'utf-8' and enc:upper()
    end
}
M.FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and fmt:upper()
    end
}

M.FileSize = {
    provider = function()
        -- stackoverflow, compute human readable file size
        local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        fsize = (fsize < 0 and 0) or fsize
        if fsize < 1024 then
            return fsize .. suffix[1]
        end
        local i = math.floor((math.log(fsize) / math.log(1024)))
        return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
    end
}
M.FileLastModified = {
    -- did you know? Vim is full of functions!
    provider = function()
        local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
        return (ftime > 0) and os.date("%c", ftime)
    end
}


-- Defining Blocks
M.FileNameBlock = utils.insert(M.Base,
    M.FileIcon,
    utils.insert(
        M.FileNameModifier,
        M.FileName
    ),
    M.FileFlags,
    { provider = '%<' }
)
M.FileTypeBlock = {
    M.FileType,
    M.FileEncoding,
    M.FileFormat
}


return M
