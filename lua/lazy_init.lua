-- Bootstrapping the installation of lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- Registering the plugins
require("lazy").setup({
    ---------------------------------------------------------------
    -- Misc
    ---------------------------------------------------------------
    -- Tmux Navigator
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            require "config/nvim-tmux-navigation"
        end,
    },
    -- Fugitive (Git interface)
    {
        "tpope/vim-fugitive",
        config = function()
            require "config/fugitive"
        end,
    },
    -- vimspector
    { "puremourning/vimspector" },
    -- Terminal
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require "config/toggleterm"
        end,
    },
    -- Persisted
    {
        "olimorris/persisted.nvim",
        enabled = false,
        config = function()
            require("config/persisted")
        end,
    },

    ---------------------------------------------------------------
    -- Colors / Looks
    ---------------------------------------------------------------
    -- Catpuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require "config/catppuccin"
        end,
    },
    -- zenmode
    {
        "folke/zen-mode.nvim",
        config = function()
            require "config/zen-mode"
        end,
    },
    -- gitsigns
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require "config/gitsigns"
        end,
    },
    -- Heirline
    {
        "rebelot/heirline.nvim",
        config = function()
            require "core/colors"
            require "config/heirline"
        end,
        enabled = false
    },
    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("config/lualine")
        end,
    },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    ---------------------------------------------------------------
    -- Files / Buffers
    ---------------------------------------------------------------
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "config/telescope"
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-vimspector.nvim",
        dependencies = { "puremourning/vimspector" },
    },

    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker"
        },
        config = function()
            require "config/neo-tree"
        end,
    },
    -- Undotree
    {
        "mbbill/undotree",
        config = function()
            require "config/undotree"
        end,
    },
    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require "config/harpoon"
        end,
    },

    ---------------------------------------------------------------
    -- Syntax Highlighting
    ---------------------------------------------------------------
    -- Treesitter (parser/syntax highlighting)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        config = function()
            require "config/treesitter"
        end,
    },
    -- Playground
    { "nvim-treesitter/playground" },

    ---------------------------------------------------------------
    -- Language Servers
    ---------------------------------------------------------------
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = 'v2.x',
        lazy = false,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },                  -- Required
            { 'hrsh7th/cmp-nvim-lsp' },              -- Required
            { 'L3MON4D3/LuaSnip' },                  -- Required
        },
        config = function()
            require "config/lsp"
        end,
    },
    -- context inspection
    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require "config/navic"
        end,
    },

    ---------------------------------------------------------------
    -- Python
    ---------------------------------------------------------------
    {
        "hattya/python-indent.vim",
        config = function()
            require "config/python-indent"
        end,
    },
    -- context inspection
})
