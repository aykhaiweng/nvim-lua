return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            local builtin = require("telescope.builtin")
            local actions = require("telescope.actions")

            -- extensions
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")

            -- setup
            require("telescope").setup({
                defaults = {
                    prompt_prefix = "   ",
                    path_display = { "truncate" },
                    mappings = {
                        i = {
                            ["<ESC>"] = actions.close,
                            ["<C-c>"] = actions.close,
                            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                        }
                    },
                    layout_config = {
                        preview_width = 0.6,
                        preview_cutoff = 120,
                        height = 0.8
                    }
                },
            })

            -- remaps
            vim.keymap.set("n", "<leader>pf", builtin.fd, {})
            vim.keymap.set("n", "<leader>pr", builtin.oldfiles, {})
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})
            vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

            -- remaps for lsp
            vim.keymap.set("n", "<leader>plr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>pls", builtin.lsp_workspace_symbols, {})

            -- remaps for diagnostics
            vim.keymap.set("n", "<leader>pld", builtin.diagnostics, {})

            -- remaps for treesitter
            vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
}
