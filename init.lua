--[[

Neovim init file
Maintainer: aykhaiweng

--]]
vim.g.mapleader = " "

-- Core init
require("lazy_init")
require("core/options")
require("core/keymaps")
require("core/colors")
-- Plugin Configurations
-- require("config/fidget") -- LSP status
-- require("config/luasnip") -- Snippets


-- vim.cmd([[
--     augroup ReloadConfig
--         autocmd!
--         autocmd BufWritePost *.lua source $MYVIMRC
--         autocmd BufWritePost *.lua lua require("lazy.core.loader").reload(require("lazy.core.config").plugins["heirline.nvim"])
--     augroup END
-- ]])
