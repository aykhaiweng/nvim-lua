return {
    {
        "Bekaboo/dropbar.nvim",
        event = {"BufReadPre", "BufNewFile"},
        enabled = false,
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
