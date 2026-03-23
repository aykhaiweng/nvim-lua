# AGENTS.md

This is a **Neovim configuration** repository written in Lua, using `lazy.nvim` for plugin management.

## Build/Lint/Test Commands

This is a configuration repository (not a runtime project), so there are no traditional build/test commands. However:

### Linting & Formatting

**Lua formatting:**
```bash
stylua --check lua/
```

**Lua linting (with lua_ls):**
- Open any Lua file in Neovim and run `:lua vim.diagnostic.open_float()` or let `lua_ls` show diagnostics inline.

**Conform.nvim (format on save):**
- Files are auto-formatted via conform.nvim when you save (configured per-filetype).
- Manual trigger: `<leader>ff` (Normal/Visual mode)

**nvim-lint (currently disabled):**
- Currently set to `enabled = false` in `lua/plugins/linting/nvim-lint.lua`
- If re-enabled, run `:Lint` or use `<leader>fl`

### Plugin Management

```bash
# Open lazy.nvim UI
nvim +Lazy

# Sync plugins
nvim +Lazy sync
```

### Testing Individual Plugins

To test a specific plugin configuration:
1. Open Neovim with the specific plugin loaded: `nvim --startuptime startup.log`
2. Check plugin status: `:Lazy`
3. View logs: `:Lazy debug`

---

## Code Style Guidelines

### General Conventions

1. **File Structure:**
   - `init.lua` - Entry point
   - `lua/core/` - Core Neovim settings (options, keymaps, autocmds, etc.)
   - `lua/plugins/` - Plugin configurations organized by category
   - `lua/lsp/` - LSP server-specific configurations
   - `lua/utils/` - Shared utility modules
   - `after/ftplugin/` - Filetype-specific settings

2. **Indentation:** 4 spaces (enforced via `vim.opt.expandtab = true`)

3. **Line Length:** Soft wrap enabled (`vim.opt.wrap = true`); no hard line length limit

4. **Comments:**
   - Use `--` for single-line comments
   - Use descriptive comments for non-obvious code
   - Minimize comments unless explaining "why" something is done

### Plugin Configuration Pattern

Follow this structure for new plugins:

```lua
--- Optional: Short description
return {
  "author/plugin-name",
  -- lazy = true by default for most plugins
  event = { "BufReadPre", "BufNewFile" },  -- or cmd = {}, keys = function() return {} end
  dependencies = {
    { "dependency/plugin" },
  },
  opts = {
    -- plugin-specific options
  },
  config = function(_, opts)
    local plugin = require("plugin")
    plugin.setup(opts)
  end,
}
```

### Keymaps

- **Leader key:** ` ` (Space)
- **Local leader:** `\` (Backslash)
- **Always provide `desc` field** for documentation:

```lua
vim.keymap.set("n", "<leader>ff", function() end, { desc = "Description here" })
```

- **Use `vim.keymap.set()` over `vim.api.nvim_set_keymap()`**
- **Modes:** `"n"`, `"i"`, `"v"`, `"x"`, `"t"`, or arrays like `{ "n", "v" }`

### Variables & Naming

- **Local variables:** `local my_variable`
- **Module-level:** `local M = {}` pattern for exportable modules
- **Naming conventions:**
  - Variables: `snake_case`
  - Functions: `snake_case`
  - Tables/Modules: `PascalCase` for exported modules
  - Augroups: `PascalCase` or `SCREAMING_SNAKE_CASE`
  - Keymap descriptions: Start with verb, capitalize (e.g., `"Go to definition"`)

### Autocommands

```lua
-- Create augroup with clear = true for idempotency
local my_group = vim.api.nvim_create_augroup("MyGroup", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = my_group,
  pattern = "*.lua",
  callback = function(event)
    -- event.buf, event.file, etc.
  end,
  desc = "Description of what this does",
})
```

### Error Handling

- **Use `pcall` for optional dependencies:**

```lua
local ok, edgy = pcall(require, "edgy")
if ok then
  -- Use edgy
end
```

- **Use `vim.v.shell_error` for shell command checks:**

```lua
local result = vim.fn.system({ "git", "status" })
if vim.v.shell_error ~= 0 then
  -- Handle error
end
```

### Imports

```lua
-- Prefer require for modules
local lspconfig = require("lspconfig")
local conform = require("conform")

-- Only use vim.cmd for Vim commands that have no Lua equivalent
vim.cmd("wincmd =")

-- Avoid global require spam; use local when possible
```

### Types

- Use LuaLS annotations for type hints when beneficial:

```lua
---@type opencode.Opts
vim.g.opencode_opts = { }

---@param opts opencode.Opts
local function setup(opts)
end
```

### Common Patterns

**Safe executable check:**
```lua
if vim.fn.executable("python3") == 1 then
  -- use it
end
```

**Platform-specific:**
```lua
if jit and jit.os == "OSX" then
  -- macOS-specific code
end
```

**Table extension (never mutate originals):**
```lua
local merged = vim.tbl_deep_extend("force", default_opts, user_opts)
```

**Conditional lazy loading:**
```lua
-- By event
event = { "BufReadPre", "BufNewFile" }

-- By command
cmd = { "Glow" }

-- By keys (load only when key is pressed)
keys = function()
  return { { "gr", function() end, desc = "..." } }
end
```

---

## File Organization

When adding new plugins, place them in the appropriate category:

| Category | Description |
|----------|-------------|
| `plugins/ai/` | AI integrations (opencode, codecompanion, etc.) |
| `plugins/editor/` | Editor enhancements (indentation, folding, etc.) |
| `plugins/formatting/` | Formatting plugins (conform) |
| `plugins/git/` | Git integration (gitsigns) |
| `plugins/linting/` | Linting plugins (nvim-lint) |
| `plugins/lsp/` | LSP-related plugins |
| `plugins/navigation/` | File/buffer navigation (telescope, neo-tree) |
| `plugins/terminal/` | Terminal integration |
| `plugins/treesitter/` | Treesitter configuration |
| `plugins/ui/` | UI enhancements (lualine, noice) |

If adding a new category, update `lua/lazy_init.lua` with the import.

---

## Reference Documentation

- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [lua_ls configuration](https://luals.github.io/)
