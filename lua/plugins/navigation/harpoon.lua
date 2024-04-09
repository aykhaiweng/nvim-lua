return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup({})

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, {desc = "Add to Harpoon"})
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = "Open Harpoon"})
        end,
    },
}
