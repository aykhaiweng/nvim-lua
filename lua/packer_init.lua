-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile>
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    -- Plugins go here


    -- colorscheme
    use({ "catppuccin/nvim", as = "catppuccin" })
    -- Devicons
    use("nvim-tree/nvim-web-devicons")
    -- Heirline
    use("rebelot/heirline.nvim")
    -- neotree
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker"
        }
    }

    -- Telescope (fuzzyfinder) -- requires rg and fd
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- extension: telescope-media
    use({ "dharmx/telescope-media.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- extension: telescope-ui-select
    use({ "nvim-telescope/telescope-ui-select.nvim", requires = { "nvim-lua/plenary.nvim" } })
    -- extension: vimspector
    use({ "nvim-telescope/telescope-vimspector.nvim", requires = { "puremourning/vimspector" } })
    -- Harpoon (File explorer)
    use({ "ThePrimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } })
    -- Undotree
    use("mbbill/undotree")

    -- Treesitter (parser/syntax highlighting)
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    -- Playground
    use("nvim-treesitter/playground")
    -- Language Server Protocol
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            -- Snippet Collection (Optional)
            { "rafamadriz/friendly-snippets" },
        }
    })
    -- context inspection
    use({"SmiteshP/nvim-navic", requires = { "neovim/nvim-lspconfig" } })
    -- fidget for displaying LSP progress
    use("j-hui/fidget.nvim")

    -- Fugitive (Git interface)
    use("tpope/vim-fugitive")
    -- lazygit
    use("kdheepak/lazygit.nvim")
    -- gitsigns
    use("lewis6991/gitsigns.nvim")

    -- vimspector
    use("puremourning/vimspector")

    -- zenmode
    use("folke/zen-mode.nvim")

    -- Tmux and vim navigation
    use("christoomey/vim-tmux-navigator")

    -- Impatient (improved loading for nvim by caching chunks
    -- use("lewis6991/impatient.nvim")

    -- persistence (Automatic session loading)
    use({ "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
    })

    -- Highlighting color codes in NVIM
    use("norcalli/nvim-colorizer.lua")


    -- Automatically set up your configuration after cloning
    -- packer.nvim.
    if packer_bootstrap then
        require("packer").sync()
    end
end)
