local layouts = require("config/heirline/layouts")

-- invoke colors
require("config/heirline/colors").setup_colors()

-- invoke layout
layouts.default.setup_vim()
require("heirline").setup({
    statusline = layouts.default.StatusLine,
    winbar = layouts.default.WinBars,
    tabline = layouts.default.Tabline,
})
