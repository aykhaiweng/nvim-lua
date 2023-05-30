local M = {}


local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local c = require("config/heirline/consts")
local vimode = require("config/heirline/components/vimode")
local files = require("config/heirline/components/files")
local rulers = require("config/heirline/components/rulers")
local lsp = require("config/heirline/components/lsp")
local diag = require("config/heirline/components/diagnostics")
local git = require("config/heirline/components/git")
local term = require("config/heirline/components/terminal")
local win = require("config/heirline/components/win")
local tabs = require("config/heirline/components/tabs")

function M.setup_vim()
    -- vim options
    vim.cmd "set noshowmode"
    vim.cmd "set showcmd"
    vim.o.showtabline = 1
    vim.o.laststatus = 3
    vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
end

return M
