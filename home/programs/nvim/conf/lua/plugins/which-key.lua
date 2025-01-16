return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			icons = {
				mappings = false
			}
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},

			{ "<leader>f", group = "Files" },
			{ "<leader>fs", group = "Save File" },
			{ "<leader>fss", "<cmd>w<cr>", desc = "Save File & Stay" },
			{ "<leader>fsq", "<cmd>x<cr>", desc = "Save File & Exit NeoVim" },

			{ "<leader>b", group = "Buffers" },
			{ "<leader>bp", "<cmd>bp<cr>", desc = "Previous Buffer" },
			{ "<leader>bn", "<cmd>bn<cr>", desc = "Next Buffer" },
			{ "<leader>be", group = "Empty Buffer" },
			{ "<leader>beh", "<cmd>new<cr>", desc = "Open in Horizontally Split Window" },
			{ "<leader>bev", "<cmd>vnew<cr>", desc = "Open in Vertically Split Window" },
			{ "<leader>bew", "<cmd>enew<cr>", desc = "Open in Current Window" },
			{ "<leader>bet", "<cmd>tabnew<cr>", desc = "Open in New Tab" },
			{ "<leader>bd", "<cmd>bd<cr>", desc = "Delete & Remove from Buffer List" },
			{ "<leader>bD", "<cmd>bw<cr>", desc = "Wipe Buffer (Caution!)" },

			{ "<leader>w", function() require("which-key").show({ keys = "<c-w>", loop = true }) end, desc = "Windows" }
		}
	}
}
