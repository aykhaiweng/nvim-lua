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
--         autocmd BufWritePost *.lua lua require('plenary.reload').reload_module('lazy_init', true)
--         autocmd BufWritePost *.lua lua require('plenary.reload').reload_module('core', true)
--         autocmd BufWritePost *.lua lua require('plenary.reload').reload_module('config', true)
--         autocmd BufWritePost *.lua lua require('plenary.reload').reload_module('snippets', true)
--         autocmd BufWritePost *.lua source $MYVIMRC
--     augroup END
-- ]])
