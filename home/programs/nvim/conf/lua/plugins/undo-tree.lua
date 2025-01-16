return {
	{
		'mbbill/undotree',
		config = function()
			require('which-key').add({
				{ "<leader>Mu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo-Tree Panel" }
			})
		end
	}
}
