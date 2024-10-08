return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {},
        cmd = {
            "ToggleTerm",
        },
        keys = function()
            local Terminal = require("toggleterm.terminal").Terminal
            local cwd = vim.fn.getcwd()

            -- Project Terminal
            local _project_terminal = Terminal:new({
                cmd = string.format('tmuxattach _floaters %s zsh "source-file $HOME/.tmux-popup.conf"', cwd),
                hidden = false,
                size = 20,
            })
            function ProjectTerminal_toggle()
                _project_terminal:toggle()
            end

            local keymaps = {
                {
                    "<F5>",
                    "<cmd>lua ProjectTerminal_toggle()<cr>",
                    mode = { "n", "i", "t" },
                    desc = "Toggle Project Terminal",
                },
            }

            if vim.g.neovide then
                -- Lazygit
                local _lazygit_terminal = Terminal:new({
                    cmd = string.format('tmuxattach _lazygit %s lazygit "source-file $HOME/.tmux-popup.conf"', cwd),
                    hidden = false,
                    direction = "float",
                })
                function LazygitTerminal_toggle()
                    _lazygit_terminal:toggle()
                end

                -- Lazydocker
                local _lazydocker_terminal = Terminal:new({
                    cmd = string.format('tmuxattach _lazydocker %s lazydocker "source-file $HOME/.tmux-popup.conf"', cwd),
                    hidden = false,
                    direction = "float",
                })
                function LazydockerTerminal_toggle()
                    _lazydocker_terminal:toggle()
                end

                table.insert(keymaps, {
                    "<F2>",
                    "<cmd>lua LazygitTerminal_toggle()<cr>",
                    mode = { "n", "i", "t" },
                    desc = "Toggle Lazygit",
                })
                table.insert(keymaps, {
                    "<F3>",
                    "<cmd>lua LazydockerTerminal_toggle()<cr>",
                    mode = { "n", "i", "t" },
                    desc = "Toggle Lazydocker",
                })
            end

            return keymaps
        end,
        config = function(_, opts)
            require("toggleterm").setup(opts)
        end,
    },
}
