-- Python implementation
vim.g.python3_host_prog = os.getenv("HOME") .. "/.pyenv/versions/neovim3/bin/python3"

-- Stop my GUI terminal from rendering it's cursor over mine
vim.opt.guicursor = ""

-- mouse
vim.opt.mouse = "a"

-- set line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Focus on the split window when opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show whitespaces, tabs and spaces
vim.opt.listchars = "tab:--,trail:·,nbsp:~,extends:>,precedes:<"
vim.opt.list = true

-- indents - use 4 spaces as default
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- smart indents
-- vim.opt.smartindent = true

-- stops vim from wrapping lines
vim.opt.wrap = true

-- swaps and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
vim.opt.undofile = true

-- search hightlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- search behaviour
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- terminal colors
vim.opt.termguicolors = true

-- scrolloff
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- updatetime
vim.opt.updatetime = 50

-- cursor
-- vim.cmd([[ let &t_SI = "\e[6 q" ]])
-- vim.cmd([[ let &t_EI = "\e[2 q" ]])
-- vim.cmd([[ set guicursor=n-v-c:block-Cursor ]])
-- vim.cmd([[ set guicursor+=i-ci-ve:ver25 ]])
-- vim.cmd([[ set guicursor+=r-cr:block-Cursor ]])
-- vim.cmd([[ set guicursor+=a:blinkwait700-blinkoff400-blinkon250 ]])
