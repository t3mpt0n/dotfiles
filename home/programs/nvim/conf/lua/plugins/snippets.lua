return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			ls.config.set_config({
				enable_autosnippets = true,
				store_selection_keys = "<Tab>"
			})
			vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
			vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
			require("luasnip.loaders.from_lua").lazy_load({ paths = "/etc/nixos/home/programs/nvim/snippets" })
		end
	}
}
