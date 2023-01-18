local utils = require("heirline.utils")

M = {}

-- funciton to return a table of colors
function M.get_colors()
    return {
        -- defaults
        statusline = utils.get_highlight("StatusLineNC").bg,
        statusline_fg = utils.get_highlight("StatusLineNC").fg,
        statusline_nc = utils.get_highlight("StatusLine").bg,
        statusline_nc_fg = utils.get_highlight("StatusLine").fg,
        tabline = utils.get_highlight("Tabline").bg,
        tabline_fg = utils.get_highlight("Tabline").fg,
        tablinesel = utils.get_highlight("TablineSel").bg,
        tablinesel_fg = utils.get_highlight("TablineSel").fg,
        normal = utils.get_highlight("Normal").bg,
        -- backgrounds
        bg0 = utils.get_highlight("CursorLine").bg,
        bg1 = utils.get_highlight("SignColumn").fg, -- Same as the background
        bg2 = "#585B70", -- this is catpuccin mocha surface2
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        -- colors
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = utils.get_highlight("DiffDelete").bg,
        git_add = utils.get_highlight("DiffAdded").fg,
        git_change = utils.get_highlight("DiffChanged").fg,
    }
end

-- cache the colors
M.colors = M.get_colors()

-- setup the colors for heirline
function M.setup_colors(colors)
    colors = M.colors or M.get_colors()
    require('heirline').load_colors(colors)
end

-- setup augroup for heirline to
-- change colors on colorscheme change
vim.api.nvim_create_augroup("Heirline", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local colors = M.colors
        utils.on_colorscheme(colors)
    end,
    group = "Heirline",
})

return M
