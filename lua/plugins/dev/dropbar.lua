return {
    {
        "Bekaboo/dropbar.nvim",
        event = {"BufReadPre", "BufNewFile"},
        opts = {
            icons = {
                ui = {
                    bar = {
                        separator = "> ",
                        extends = ""
                    }
                }
            }
        }
    }
}
