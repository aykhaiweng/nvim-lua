--[[

Neovim init file
Maintainer: aykhaiweng

--]]

-- Core init
require("packer_init")
require("core/options")
require("core/keymaps")
require("config/catppuccin") -- colorscheme
require("core/colors")
-- Plugin Configurations
require("config/lsp") -- language server
require("config/fidget") -- LSP status
require("config/treesitter") -- syntax highlighting
require("config/harpoon") -- file mark and explore
require("config/undotree") -- git-like undo history
require("config/telescope") -- fuzzy finder
require("config/neo-tree") -- filebrowser
require("config/fugitive") -- git plugin for nvim
require("config/zen-mode") -- changes a buffer to fullscreen
require("config/lazygit") -- Popup for lazygit in nvim
require("config/gitsigns") -- gitsigns in the sign column
require("config/heirline") -- God's gift to this green earth
require("config/luasnip") -- Snippets
