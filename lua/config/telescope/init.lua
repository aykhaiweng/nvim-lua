local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local themes = require("telescope.themes")

-- extensions
require("telescope").load_extension("media")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("vimspector")

-- variables
local default_file_ignore_patterns = {
    ".git/*",
    "node_modules/*",
    "__pycache__/*"
}


-- setup
require("telescope").setup({
    defaults = {
        -- rg
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--hidden",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
        },
        prompt_prefix = "   ",
        -- mappings
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-c>"] = actions.close,
                ["<C-j>"] = {
                    actions.move_selection_next, type = "action",
                    opts = { nowait = true, silent = true }
                },
                ["<C-k>"] = {
                    actions.move_selection_previous, type = "action",
                    opts = { nowait = true, silent = true }
                }
            }
        },
        layout_config = {
            preview_width = 0.6,
            preview_cutoff = 120,
            height = 0.8
        }
    },
    pickers = {
        fd = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "-uu", "--hidden"},
            hidden = true,
            smartcase = true,
            file_ignore_patterns = default_file_ignore_patterns,
        },
        git_files = {
            smartcase = true,
        },
        grep_string = {
            hidden = true,
            smartcase = true,
            file_ignore_patterns = default_file_ignore_patterns,
        }
    },
    extensions = {
        media = {
            backend = "viu", -- "none"|"ueberzug"|"viu"|"chafa"|"jp2a"|"catimg"
            move = true, -- experimental GIF preview
            cache_path = "/tmp/tele.media.cache",
        },
        ["ui-select"] = {
            themes.get_dropdown({})
        }
    }
})

-- remaps
vim.keymap.set("n", "<leader>pf", builtin.fd, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- remaps for vimspector
vim.keymap.set("n", "<leader>vs", require("telescope").extensions.vimspector.configurations, {})

-- remaps for lsp
vim.keymap.set("n", "<leader>plr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>pls", builtin.lsp_workspace_symbols, {})

-- remaps for diagnostics
vim.keymap.set("n", "<leader>pd", builtin.diagnostics, {})

-- remaps for treesitter
vim.keymap.set("n", "<leader>ts", builtin.treesitter, {})
