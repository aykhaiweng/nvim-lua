return {
    'VonHeikemen/searchbox.nvim',
    event = "VeryLazy",
    version = "*",
    dependencies = {
        {'MunifTanjim/nui.nvim'}
    },
    config = function()
        require("searchbox").setup()
        vim.keymap.set('n', '/', ':SearchBoxIncSearch<CR>')
    end
}
