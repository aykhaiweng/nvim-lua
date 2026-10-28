-- Native LSP: each server's config is lsp/<name>.lua on the runtimepath,
-- picked up by vim.lsp.config; this file only chooses which ones run.

vim.lsp.enable({
	"lua_ls",
	"basedpyright",
	"terraformls",
	"tflint",
})

-- TODO(skeleton): LspAttach keymaps beyond the 0.11+ defaults (grn, gra, grr, gri, K)
