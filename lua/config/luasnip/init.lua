local ls = require("luasnip")

-- Setup
ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
})

-- keybinds
-- press <Tab> to expand or jump in a snippet. These can also be mapped separately
vim.cmd([[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]])
vim.cmd([[snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>]])

-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
vim.cmd([[imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']])
vim.cmd([[smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']])


-- load
require("luasnip.loaders.from_snipmate").lazy_load()
