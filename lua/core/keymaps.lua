-- Changing the leader symbol
-- vim.g.mapleader = " "

-- Bind C-c to <Esc>
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-c>", "<Esc>")
-- Unbinding capital Q
vim.keymap.set("n", "Q", "<nop>", { desc = "DISABLED" })

-- tabs
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew, { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tj", vim.cmd.tabfirst, { desc = "Go to first tab" })
vim.keymap.set("n", "<leader>tl", vim.cmd.tabnext, { desc = "Go to tab on right" })
vim.keymap.set("n", "<leader>th", vim.cmd.tabprev, { desc = "Go to tab on the left" })
vim.keymap.set("n", "<leader>tk", vim.cmd.tablast, { desc = "Go to last tab" })
vim.keymap.set("n", "<leader>tt", [[<C-w>T]], { desc = "Break out current file to new tab" })
vim.keymap.set("n", "<leader>tm", ":tabm ", { desc = "Move tab to index" })
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose, { desc = "Close tab" })

-- resize windows
vim.keymap.set("n", "<M-l>", "<C-w>>", { desc = "Increase width" })
vim.keymap.set("n", "<M-h>", "<C-w><", { desc = "Decrease width" })
vim.keymap.set("n", "<M-j>", "<C-w>-", { desc = "Increase height" })
vim.keymap.set("n", "<M-k>", "<C-w>+", { desc = "Decrease height" })
vim.keymap.set("n", "<M-=>", "<C-w>=", { desc = "Standardize widths" })

-- move cursor in edit mode
vim.keymap.set("i", "<M-h>", "<left>", { desc = "Cursor left" })
vim.keymap.set("i", "<M-j>", "<down>", { desc = "Cursor down" })
vim.keymap.set("i", "<M-k>", "<up>", { desc = "Cursor up" })
vim.keymap.set("i", "<M-l>", "<right>", { desc = "Cursor right" })

-- toggle hightlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- visual line move -- It will automatically indent with =
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("n", "<leader>ff", "gg=G''", { desc = "Format using gg=G" })

-- Change behaviour of J to move bottom line to current line without
-- moving the cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Move the bottom line to current line without moving cursor" })

-- This will paste but not override the register. In cases
-- like pasting over existing text, it does not take
-- existing text into the register
vim.keymap.set("x", "P", '"_dP', { desc = "Paste without overriding default register" })
vim.keymap.set("v", "P", '"_dP', { desc = "Visual paste without overriding the register" })
-- This will yank into the system clipboard, useful when
-- separating the vim and system clipboards
vim.keymap.set("v", "Y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "Y", '"+Y', { desc = "Yank to system clipboard" })
-- Deletes to empty register
vim.keymap.set("v", "D", '"_d', { desc = "Delete to empty register" })
-- Cuts to empty register
vim.keymap.set("v", "X", '"_x', { desc = "Cut to empty register" })

-- tmux-sessionizer
-- vim.keymap.set("n", "<leader>po", "<cmd>silent !tmux neww tms<CR>")

-- Imba substitute command
vim.keymap.set(
	"n",
	"<leader>ew",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Substitute word under cursor" }
)
vim.keymap.set("v", "<leader>es", [[:s/]], { desc = "Make substitution under selection" })

-- set breakpoints
-- vim.keymap.set("n", "<leader>bp", vim.cmd.Break, { desc = "Create breakpoint under cursor" })

-- Folding
vim.keymap.set("n", "<leader><space>", "za", { desc = "Toggle fold under cursor" })
-- vim.keymap.set("n", "<CR>", "za", {desc = "Toggle fold under cursor"})

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit out of Terminal Insert" })
