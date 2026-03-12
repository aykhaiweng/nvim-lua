-- Improvement 5: Safer Python host prog
local python_path = os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/python3"
if vim.fn.executable(python_path) == 1 then
	vim.g.python3_host_prog = python_path
end

-- Enable project level .nvim.lua 
vim.o.exrc = true

-- Stop my GUI terminal from rendering it's cursor over mine
vim.opt.guicursor = ""

-- Improvement 3: Modernize Core Options
vim.opt.hidden = true
vim.opt.autoread = true

-- mouse
vim.opt.mouse = "a"

-- set line numbers
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

-- text truncation
vim.opt.display = "lastline"

-- Focus on the split window when opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show whitespaces, tabs and spaces
vim.opt.listchars = "tab:--,trail:·,nbsp:~,extends:>,precedes:<"
vim.opt.list = false
-- vim.opt.fillchars = { eob = "" }  -- Removing the tilde from the
-- vim.opt.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

-- indents - use 4 spaces as default
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "99"

-- smart indents
vim.opt.smartindent = true

-- stops vim from wrapping lines
vim.opt.wrap = true

-- swaps and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
vim.opt.undofile = true

-- search hightlighting
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- search behaviour
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- terminal colors
vim.opt.termguicolors = true

-- scrolloff
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20

-- sign column
vim.opt.signcolumn = "yes"

-- I can't remember what this is for but it's in all my configs
-- so here it is.
vim.opt.isfname:append("@-@")

-- updatetime
vim.opt.updatetime = 200

-- clipboard
vim.opt.clipboard = ""

-- Improvement 3: Modernize Cursor
vim.opt.guicursor = {
	"n-v-c:block-Cursor",
	"i-ci-ve:ver25",
	"r-cr:block-Cursor",
	"a:blinkoff400-blinkon200",
}

-- Start autoinsert
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "term://*",
  command = "startinsert!",
})
