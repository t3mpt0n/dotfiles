local tb = require("telescope.builtin")
return {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("which-key").add({
				{ "<leader>ff", function() tb.find_files() end, desc = "Find Files" }
			})
		end
	}
}
