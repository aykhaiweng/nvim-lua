-- terminal colors
vim.opt.termguicolors = true
-- dark background
vim.opt.background = "dark"

-- Diagnostic Icons
vim.diagnostic.config({
    DiagnosticSignError = { text = "", texthl = "DiagnosticsError" },
    DiagnosticSignWarn = { text = "", texthl = "DiagnosticsWarn" },
    DiagnosticSignInfo = { text = "", texthl = "DiagnosticsInfo" },
    DiagnosticSignHint = { text = "", texthl = "DiagnosticsHint" }
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
