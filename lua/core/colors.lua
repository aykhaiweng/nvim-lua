-- terminal colors
vim.opt.termguicolors = true
-- dark background
vim.opt.background = "dark"

-- Diagnostic Icons
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticsError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticsWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticsInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticsHint" })

-- Cursor
local CursorLineGroup = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
	{ "VimEnter", "WinEnter", "BufWinEnter" },
	{ pattern = "*", command = "set cursorline", group = CursorLineGroup }
)
vim.api.nvim_create_autocmd({ "WinLeave" }, { pattern = "*", command = "set nocursorline", group = CursorLineGroup })
