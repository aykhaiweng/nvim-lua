return {
    {
        "folke/trouble.nvim",
        branch = "dev",
        event = "VeryLazy",
        config = function()
            require("trouble").setup()

            vim.keymap.set("n", "<leader>ll", [[:Trouble loclist toggle focus=false filter.buf=0<CR>]], {desc = "Open Trouble"})
            vim.keymap.set("n", "<leader>lL", [[:Trouble loclist toggle focus=false<CR>]], {desc = "Open Trouble"})
            vim.keymap.set("n", "<leader>ld", [[:Trouble diagnostics toggle focus=false filter.buf=0<CR>]], {desc = "Open Trouble"})
            vim.keymap.set("n", "<leader>lD", [[:Trouble diagnostics toggle focus=false<CR>]], {desc = "Open Trouble"})
        end
    }
}
