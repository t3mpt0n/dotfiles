return {
	{
		'mfussenegger/nvim-lint',
		event = {
			"BufReadPre",
			"BufNewFile"
		},
		config = function()
			local wk = require("which-key")
			local lint = require("lint")
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end
			})
			wk.add({
				{ "<leader>fl", function() lint.try_lint() end, desc = "Trigger Linting for Current File"}
			})
		end
	}
}
