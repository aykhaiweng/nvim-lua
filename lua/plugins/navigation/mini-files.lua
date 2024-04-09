return {
    { 
        'echasnovski/mini.files',
        version = '*',
        config = function()
            require('mini.files').setup({
                -- Customization of shown content
                content = {
                  -- Predicate for which file system entries to show
                  filter = nil,
                  -- What prefix to show to the left of file system entry
                  prefix = nil,
                  -- In which order to show file system entries
                  sort = nil,
                },

                -- Module mappings created only inside explorer.
                -- Use `''` (empty string) to not create one.
                mappings = {
                  close       = 'q',
                  go_in       = 'L',
                  go_in_plus  = '<CR>',
                  go_out      = 'H',
                  go_out_plus = '',
                  reset       = '<BS>',
                  reveal_cwd  = '@',
                  show_help   = 'g?',
                  synchronize = '=',
                  trim_left   = '<',
                  trim_right  = '>',
                },

                -- General options
                options = {
                  -- Whether to delete permanently or move into module-specific trash
                  permanent_delete = true,
                  -- Whether to use for editing directories
                  use_as_default_explorer = true,
                },

                -- Customization of explorer windows
                windows = {
                  -- Maximum number of windows to show side by side
                  max_number = math.huge,
                  -- Whether to show preview of file/directory under cursor
                  preview = false,
                  -- Width of focused window
                  width_focus = 50,
                  -- Width of non-focused window
                  width_nofocus = 15,
                  -- Width of preview window
                  width_preview = 80,
                },
            })


            -- toggle
            local minifiles_toggle = function()
              if not MiniFiles.close() then MiniFiles.open() end
            end
            vim.keymap.set("n", "<C-b>", minifiles_toggle, {desc = "File explorer"})

            -- show current file
            local minifiles_show_current_file = function()
              MiniFiles.open(vim.api.nvim_buf_get_name(0))
              MiniFiles.reveal_cwd()
            end
            vim.keymap.set("n", "<leader>-", minifiles_show_current_file, {desc = "Reveal current file"})

            -- imba split keybinds
            local map_split = function(buf_id, lhs, direction)
              local rhs = function()
                -- Make new window and set it as target
                local new_target_window
                vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
                  vim.cmd(direction .. ' split')
                  new_target_window = vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target_window)
              end

              -- Adding `desc` will result into `show_help` entries
              local desc = 'Split ' .. direction
              vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd('User', {
              pattern = 'MiniFilesBufferCreate',
              callback = function(args)
                local buf_id = args.data.buf_id
                -- Tweak keys to your liking
                map_split(buf_id, 's', 'belowright horizontal')
                map_split(buf_id, 'v', 'belowright vertical')
              end,
            })
        end
    },
}
