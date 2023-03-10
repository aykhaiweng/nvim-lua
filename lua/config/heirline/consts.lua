-- local delimiter_chars = { "", "" }
local delimiter_chars = { "", "" }
local sub_delimiter_chars = { "", "" }
local empty = "█"

local vimodes = { -- change the strings if you like it verbose!
    n = "N",
    no = "N?",
    nov = "N?",
    noV = "N?",
    ["no\22"] = "N?",
    niI = "Ni",
    niR = "Nr",
    niV = "Nv",
    nt = "Nt",
    v = "V",
    vs = "Vs",
    V = "V_",
    Vs = "Vs",
    ["\22"] = "^V",
    ["\22s"] = "^V",
    s = "S",
    S = "S_",
    ["\19"] = "^S",
    i = "I",
    ic = "Ic",
    ix = "Ix",
    R = "R",
    Rc = "Rc",
    Rx = "Rx",
    Rv = "Rv",
    Rvc = "Rv",
    Rvx = "Rv",
    c = "C",
    cv = "Ex",
    r = "...",
    rm = "M",
    ["r?"] = "?",
    ["!"] = "!",
    t = "T",
}

local vimode_colors = {
    n = "red",
    i = "green",
    v = "cyan",
    V = "cyan",
    ["\22"] = "cyan",
    c = "orange",
    s = "purple",
    S = "purple",
    ["\19"] = "purple",
    R = "orange",
    r = "orange",
    ["!"] = "red",
    t = "red",
}

return {
    delimiter_chars = delimiter_chars,
    sub_delimiter_chars = sub_delimiter_chars,
    delimiters = delimiter_chars,
    vimodes = vimodes,
    vimode_colors = vimode_colors,
    empty = empty,
    -- heirline components
    Align = { provider = "%=" },
    Space = { provider = " " },
    Empty = { provider = empty },
    LeftDelimiter = { provider = delimiter_chars[1] },
    RightDelimiter = { provider = delimiter_chars[2] }
}
