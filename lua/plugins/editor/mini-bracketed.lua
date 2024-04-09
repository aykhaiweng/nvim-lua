return {
    {
        "echasnovski/mini.bracketed",
        version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
        config = function()
            require("mini.bracketed").setup()
        end
    }
}
