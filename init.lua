-- Entry point. Order matters: leader keys must exist before any plugin maps them.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.pack") -- installs plugins; lz.n owns when they load
require("config.lsp")
