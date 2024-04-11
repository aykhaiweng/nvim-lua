return {
    "stevearc/conform.nvim",
    lazy = true,
    keys = function()
        local conform = require("conform")
        return {
            {
                "<leader>ff",
                function()
                    conform.format({ lsp_fallback = true, async = true, timeout_ms = 2000 })
                end,
                desc = "Conform in file or range (visual)",
            },
        }
    end,
    opts = {
        formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            svelte = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            graphql = { "prettier" },
            lua = { "stylua" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
        },
    },
    config = function(_, opts)
        local conform = require("conform")
        conform.setup(opts)
    end,
}
