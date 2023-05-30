local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")


M.Base = {
    condition = conditions.is_git_repo,
    on_click = {
        callback = function()
            vim.defer_fn(function()
                vim.cmd.LazyGit()
            end, 100)
        end,
        name = "heirline_git",
    },
    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,
}
M.GitName = {
    condition = function(self)
        if (self.status_dict.head)
        then
            return true
        else
            return false
        end
    end,
    provider = function(self)
        return " " .. self.status_dict.head
    end,
    hl = { bold = true, fg = "orange" }
}
M.GitChanges = {
    {
        condition = function(self)
            local count = self.status_dict.added or 0
            return count > 0
        end,
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count .. " ")
        end,
        hl = { fg = "green" },
    },
    {
        condition = function(self)
            local count = self.status_dict.removed or 0
            return count > 0
        end,
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = "red" },
    },
    {
        condition = function(self)
            local count = self.status_dict.changed or 0
            return count > 0
        end,
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" ~" .. count)
        end,
        hl = { fg = "blue" },
    },
}
M.Fugitive = {
    provider = function()
        local branch = vim.fn.FugitiveStatusline()
        return branch
    end
}

M.GitName = utils.insert(M.Base, M.GitName)
M.GitChanges = utils.insert(M.Base, M.GitChanges)


return M
