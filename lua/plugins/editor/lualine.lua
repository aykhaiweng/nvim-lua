return {
    {
        'linrongbin16/lsp-progress.nvim',
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            -- listen lsp-progress event and refresh lualine
            vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
            vim.api.nvim_create_autocmd("User", {
                group = "lualine_augroup",
                pattern = "LspProgressStatusUpdated",
                callback = require("lualine").refresh,
            })
        end,
        config = function()
            require('lsp-progress').setup()
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        lazy = false,
        config = function()
            local disabled_filetypes = {
                "NvimTree",
                "Outline",
                "undotree",
                "trouble",
                "term",
                "gitcommit",
                "fugitive",
                "fugitiveblame"
            }
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = disabled_filetypes,
                        winbar = disabled_filetypes,
                    }, -- Commented because using full length bar
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = {
                        -- LSP Progress
                        function()
                            return require('lsp-progress').progress()
                        end,
                    },
                    lualine_y = { "encoding", "fileformat", "filetype" },
                    lualine_z = { "location", "progress" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })

            -- vim options
            vim.cmd("set noshowmode")
            vim.cmd("set showcmd")
            vim.o.laststatus = 1 -- 3 to span across
        end,
    },
}
