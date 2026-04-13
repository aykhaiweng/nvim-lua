# Neovim Config (Lua)

Modular `lazy.nvim` + `mason.nvim` setup.

## Architecture
- `init.lua`: Entry point & leader keys.
- `lua/core/`: Options, keymaps, autocmds, colors, tmux, utils.
- `lua/lazy_init.lua`: Plugin orchestration.
- `lua/plugins/`: Categorized plugin specs (`ai/`, `editor/`, `lsp/`, `ui/`, etc.).
- `lua/lsp/`: Server-specific configs.
- `after/ftplugin/`: Language-specific overrides.

## Tech Stack
- **Core**: `lazy.nvim`, `mason.nvim`, `treesitter`.
- **UI/Nav**: `telescope`, `neo-tree`, `lualine`, `snacks`, `noice`.
- **LSP/Format**: `blink`, `conform`, `nvim-lint`.
- **AI**: `codecompanion`, `gemini-companion`.

## Key Bindings (Leader: `Space`)
- `C-c` / `C-q`: `<Esc>` (Insert/Visual).
- `Y` / `P`: System clipboard optimized.
- `Alt + h/j/k/l`: Resize splits / Move in insert mode.
- `LSP`: `K` (Hover), `gd` (Def), `gr` (Ref), `gl` (Diag), `<leader>rn` (Rename).
- `Misc`: `<leader>ff` (Format), `<leader>ew` (Search/Replace word).

## Development
- **Python**: Uses `~/.pyenv/versions/neovim3/bin/python3`.
- **Local Config**: Supports `.nvim.lua` overrides.
- **Plugins**: Add to `lua/plugins/<category>/`. Import new categories in `lua/lazy_init.lua`.
