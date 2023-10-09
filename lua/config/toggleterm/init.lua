local Terminal  = require('toggleterm.terminal').Terminal

-- Setup toggleterm
require("toggleterm").setup({
    open_mapping = [[<c-\>]],
})


-- LazyGit
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 99,
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-c>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _lazygit_toggle()
  lazygit:toggle()
end

-- LazyGit
local lazydocker = Terminal:new({
  cmd = "lazydocker",
  count = 98,
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-c>", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})
function _lazydocker_toggle()
  lazydocker:toggle()
end


-- maps
vim.keymap.set("n", "<leader>tlg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>tld", "<cmd>lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})

local nvim_tmux_nav = require('nvim-tmux-navigation')
vim.keymap.set('t', '<C-q>', [[<C-\><C-n>]])
vim.keymap.set('t', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('t', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('t', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('t', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
