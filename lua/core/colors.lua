-- terminal colors
vim.opt.termguicolors = true
-- dark background
vim.opt.background = "dark"

-- Diagnostic Icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticsError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticsWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticsInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticsHint" })

function ColorMyPencils(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    -- Cursor
    vim.api.nvim_set_hl(0, "Cursor", { reverse = true })
    -- CursorLine
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#191924" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#191924", bold = true })
    -- augroup for CursorLine
    local CursorLineGroup = vim.api.nvim_create_augroup(
        "CursorLine", { clear = true }
    )
    vim.api.nvim_create_autocmd(
        { "VimEnter", "WinEnter", "BufWinEnter" },
        { pattern = "*", command = "set cursorline", group = CursorLineGroup }
    )
    vim.api.nvim_create_autocmd(
        { "WinLeave" },
        { pattern = "*", command = "set nocursorline", group = CursorLineGroup }
    )
end

ColorMyPencils()
