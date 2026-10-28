-- Autocommands, all in one augroup so re-sourcing doesn't duplicate them.
local group = vim.api.nvim_create_augroup("config", { clear = true })

-- TODO(skeleton): yank highlight, restore cursor, trim whitespace (pass `group = group`)
