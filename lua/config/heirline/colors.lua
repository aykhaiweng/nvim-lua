local utils = require("heirline.utils")

M = {}

-- funciton to return a table of colors
function M.get_colors()
    return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
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
