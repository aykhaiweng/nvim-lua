return {
    {
        "echasnovski/mini.surround",
        version = "*",
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
        config = function()
            require("mini.surround").setup()
        end
    }
}
