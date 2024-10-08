-- terminal colors
vim.opt.termguicolors = true
-- dark background
vim.opt.background = "dark"

-- Diagnostic Icons
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = ""
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticsError",
            [vim.diagnostic.severity.WARN] = "DiagnosticsWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticsInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticsHint"
        }
    }
})

-- Cursor
local CursorLineGroup = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	pattern = "*",
	command = "set cursorline",
	group = CursorLineGroup,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	pattern = "*",
	command = "set nocursorline",
	group = CursorLineGroup,
})
