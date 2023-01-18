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
        percentage = 0.15,
    },
    no_italic = true, -- Force no italic
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
        all = function()
            return {
                Cursor = { bg = "gray" }
            }
        end
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})


-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"


-- changing the cursor
vim.cmd([[ set guicursor=n-v-c:block-Cursor ]])
vim.cmd([[ set guicursor+=i-ci-ve:ver25 ]])
vim.cmd([[ set guicursor+=r-cr:block-Cursor ]])
vim.cmd([[ set guicursor+=a:blinkwait75-blinkoff400-blinkon200 ]])
