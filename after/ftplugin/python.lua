local function get_python_module_path()
	local path = vim.fn.expand("%:p") -- Get the full path of the current buffer
	local root_markers = { "pyproject.toml", "setup.py", ".git" } -- Common project root markers
	local root = vim.fs.find(root_markers, { path = path, upward = true })[1] -- Find the project root

	if not root then
		-- print("Project root not found.")
		return
	end

	root = vim.fs.dirname(root) -- Ensure root is the directory, not the file
	local relative_path = vim.fn.fnamemodify(path, ":.:r") -- Get the relative path without extension

	if not relative_path then
		-- print("Could not determine the relative path of the file.")
		return
	end

	-- Replace directory separators with dots and correct any edge cases
	local module_path = relative_path:gsub(vim.pesc(root .. "/"), ""):gsub("/", ".")

	-- Save the module path to register
	vim.fn.setreg("+", module_path) -- Copy the module path to the default register

	print("Module path:", module_path)
	return module_path
end

-- Register the function as a Neovim command
vim.api.nvim_create_user_command("PythonModulePath", get_python_module_path, {})

vim.keymap.set(
	"n",
	"<leader>ym",
	"<cmd>PythonModulePath<CR>",
	{ desc = "Yank the current python module path to system clipboard" }
)

vim.opt.colorcolumn = "99"
