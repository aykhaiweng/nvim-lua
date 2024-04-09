return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 9999,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- latte, frappe, macchiato, mocha
                background = { -- :h background
                    light = "latte",
                    dark = "mocha",
                },
                transparent_background = false,
                show_end_of_buffer = false, -- show the '~' characters after the end of buffers
                term_colors = false,
                dim_inactive = {
                    enabled = false,
                    shade = "dark",
                    percentage = 0.50,
                },
                no_italic = false, -- Force no italic
                no_bold = false, -- Force no bold
                styles = {
                    comments = {},
                    conditionals = {},
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    variables = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    types = {},
                    operators = {},
                },
                color_overrides = {},
                custom_higlights = {},
                highlight_overrides = {
                    mocha = function(c)
                        return {
                            Cursor = { bg = c.foreground, fg = c.mantle },
                            -- Borders
                            -- WinSeparator = { bg = c.mantle, fg = c.mantle },
                            -- -- Sign Column
                            -- SignColumn = { bg = c.mantle },
                            -- SignColumnSB = { bg = c.mantle },
                            -- LineNr = { bg = c.mantle },
                            -- -- Barbecue
                            -- barbecue_normal = { bg = c.mantle },
                            -- -- Trouble
                            -- TroubleNormal = { bg = c.mantle },
                            -- -- Indent Scope
                            -- MiniIndentscopeSymbol = { fg = c.flamingo },
                            -- -- Outline
                            -- OutlineNormal = { bg = c.mantle }
                        }
                    end
                },
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    notify = true,
                    barbecue = {
                        dim_dirname = true, -- directory name is dimmed by default
                        bold_basename = true,
                        dim_context = false,
                        alt_background = false,
                    }
                },
            })

            -- setup must be called before loading
            vim.cmd.colorscheme "catppuccin"

            -- Darken the Normal color
            -- flavour = require("catppuccin").flavour
            -- C = require("catppuccin.palettes").get_palette(flavour)
            -- U = require("catppuccin.utils.colors")
            -- local darken_percentage = 0.20
            -- C.dim = U.vary_color(
            --     { latte = U.darken(C.base, darken_percentage, C.mantle) },
            --     U.darken(C.base, darken_percentage, C.mantle)
            -- )

            -- local DimmedBackground = vim.api.nvim_create_augroup(
            --     "DimmedBackground", { clear = true }
            -- )
            -- vim.api.nvim_create_autocmd({"BufEnter"},
            --     {
            --         pattern = "*",
            --         callback = function(ev)
            --             local buftype = vim.bo.buftype
            --             print(buftype)
            --             if buftype == "help" or buftype == "nowrite" then
            --                 -- vim.api.nvim_set_hl(0, "Normal", { bg=C.dim }) 
            --             end
            --         end,
            --         group = DimmedBackground
            --     }
            -- )

            -- changing the cursor
            vim.cmd([[ set guicursor=n-v-c:block-Cursor ]])
            vim.cmd([[ set guicursor+=i-ci-ve:ver25 ]])
            vim.cmd([[ set guicursor+=r-cr:block-Cursor ]])
            vim.cmd([[ set guicursor+=a:blinkwait75-blinkoff400-blinkon200 ]])
        end,
    },
}
