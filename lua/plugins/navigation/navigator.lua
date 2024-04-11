return {
    {
        "numToStr/Navigator.nvim",
        lazy = true,
        keys = function()
            return {
                { "<C-h>", '<CMD>NavigatorLeft<CR>',     { "n", "t" }, desc = ":NavigatorLeft" },
                { "<C-l>", '<CMD>NavigatorRight<CR>',    { "n", "t" }, desc = ":NavigatorRight" },
                { "<C-k>", '<CMD>NavigatorUp<CR>',       { "n", "t" }, desc = ":NavigatorUp" },
                { "<C-j>", '<CMD>NavigatorDown<CR>',     { "n", "t" }, desc = ":NavigatorDown" },
            }
        end,
        config = function()
            require('Navigator').setup()
        end,
    },
}
