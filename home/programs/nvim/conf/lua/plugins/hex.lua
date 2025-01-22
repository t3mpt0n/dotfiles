return {
	{
		"RaafatTurki/hex.nvim",
		config = function()
			local hex = require("hex")
			local wk = require("which-key")
			hex.setup()
			wk.add({
				{
					"<leader>wH",
					function()
						hex.toggle()
					end,
					desc = "Toggle btwn. hex & normal view",
				},
			})
		end,
	},
}
