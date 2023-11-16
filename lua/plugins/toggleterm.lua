return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            -- Setup toggleterm
            require("toggleterm").setup({
                open_mapping = [[<c-\>]],
            })
            local nvim_tmux_nav = require('nvim-tmux-navigation')
            vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]])
            vim.keymap.set('t', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set('t', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set('t', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set('t', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        end,
    },
}
