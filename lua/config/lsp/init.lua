local lsp = require("lsp-zero")

-- Setup the recommended preset
lsp.preset("recommended")

-- A bunch of servers that we would like to ensure
-- is always installed
lsp.ensure_installed({
    'lua_ls',
    'dockerls',
    'dotls',
    'bashls',
})

-- CMP settings and mappings for when the autocomplete thing is open
local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-e>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})
-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
cmp_mappings['<CR>'] = nil
lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    set_lsp_keymaps = { omit = { '<C-k>' } },
})


-- keymaps for LSP
lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = true }

    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "L", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})


-- Setting up configuration for pylsp
-- Changing the configuration to use flake8
-- lsp.configure('pylsp', {
--     on_attach = function(client, bufnr)
--         -- Use a protected call so we don't error out on first use
--         local status_ok, navic = pcall(require, 'nvim-navic')
--         if not status_ok then
--             return
--         end
--         require("nvim-navic").attach(client, bufnr)
--     end,
--     settings = {
--         pylsp = {
--             configurationSources = { 'flake8' },
--             plugins = {
--                 pycodestyle = {
--                     enabled = false,
--                 },
--                 pyflakes = {
--                     enabled = false,
--                 },
--                 mccabe = {
--                     enabled = false,
--                 },
--                 flake8 = {
--                     enabled = true,
--                     ignore = { 'W391' },
--                 }
--             }
--         }
--     }
-- })


-- Call the setup function
lsp.setup()

-- Setting up vim's diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = true
})
