local M = {}


local consts = require("config/heirline/consts")


-- vi-mode
M.ViMode = {
    -- init
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
        if not self.once then
            vim.api.nvim_create_autocmd("ModeChanged", {
                pattern = "*:*o",
                command = 'redrawstatus'
            })
            self.once = true
        end
    end,
    -- static variables
    static = {
        mode_names = consts.vimodes,
        mode_colors = consts.vimode_colors
    },
    -- providers
    provider = function(self)
        return "%2(" .. self.mode_names[self.mode] .. "%)"
    end,
    -- update on mode change
    update = {
        "ModeChanged",
    },
}


return M
