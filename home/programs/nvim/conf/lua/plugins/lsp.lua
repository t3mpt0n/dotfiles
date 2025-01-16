local function setup_lsp(lsp, conf)
	require("lspconfig")[lsp].setup({ conf or nil })
end
local basic_lsp_list = { "nil_ls", "lua_ls", "pyright" }

local function basic_lsp_function(l)
	for _, lsp in ipairs(l) do
		setup_lsp(lsp)
	end
end
return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			basic_lsp_function(basic_lsp_list)
		end,
	},
}
