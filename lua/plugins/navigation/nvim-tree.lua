return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<C-b>",     ":NvimTreeToggle<CR>",   "n", desc = "Open file explorer" },
        { "<leader>-", ":NvimTreeFindFile<CR>", "n", desc = "Focus current file in explorer" },
    },
    config = function(opts)
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
            },
            view = {
                centralize_selection = true,
                width = {
                    min = 30,
                    max = 45,
                    padding = 2,
                },
                signcolumn = "auto",
            },
            renderer = {
                indent_width = 4,
                indent_markers = {
                    enable = true,
                },
                highlight_diagnostics = "name",
                highlight_git = "name",
                icons = {
                    git_placement = "after",
                    modified_placement = "after",
                    diagnostics_placement = "signcolumn",
                    bookmarks_placement = "signcolumn",
                },
            },
            filters = {
                enable = false,
            },
        })
    end,
}
