return {
    {
        "amitds1997/remote-nvim.nvim",
        version = "*",                       -- Pin to GitHub releases
        dependencies = {
            "nvim-lua/plenary.nvim",         -- For standard functions
            "MunifTanjim/nui.nvim",          -- To build the plugin UI
            "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
        },
        cmd = {
            "RemoteInfo",
            "RemoteStart",
            "RemoteLog",
            "RemoteStop",
            "RemoteCleanup",
            "RemoteConfigDel",
        },
        event = { "VeryLazy" },
        opts = {
            remote = {
                copy_dirs = {
                    config = {
                        dirs = { "after", "lua", "snippets" },         -- Directories inside `base` to copy over. If this is set to string ""; it means entire `base` should be copied over
                        compression = {
                            enabled = true,                            -- Should data be compressed before uploading
                            additional_opts = { "--exclude-vcs" },     -- Any arguments that can be passed to `tar` for compression can be specified here to improve your compression
                        },
                    },

                },
            }
        },
        config = function(_, opts)
            require("remote-nvim").setup(opts)
        end
    }
}
