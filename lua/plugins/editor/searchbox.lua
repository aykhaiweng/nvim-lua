return {
    'VonHeikemen/searchbox.nvim',
    event = "VeryLazy",
    version = "*",
    event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
    dependencies = {
        {'MunifTanjim/nui.nvim'}
    },
    config = function()
        require("searchbox").setup()
        vim.keymap.set('n', '/', ':SearchBoxIncSearch<CR>')
    end
}
