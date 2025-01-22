return {
	{
		"direnv/direnv.vim",
		config = function()
			vim.g.direnv_cmd = "/run/current-system/sw/bin/direnv"
			vim.g.direnv_silent_load = 1
		end,
	},
}
