local luasnip_config = function()
    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- load custom snippets from home
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })
    -- load custom snippets from current directory
    require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })
end

return {
	{
		"L3MON4D3/LuaSnip", -- snippets engine
		event = "InsertEnter",
        enabled = false,
		dependencies = {
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			"rafamadriz/friendly-snippets", -- useful snippet
		},
        config = luasnip_config,
	},
}
