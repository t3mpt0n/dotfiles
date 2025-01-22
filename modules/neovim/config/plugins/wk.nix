{
	plugins.which-key = {
		enable = true;
		settings = {
			spec =
				[
					{
						__unkeyed-1 = "<leader>?";
						__unkeyed-2.__raw = "function() require('which-key').show({ global = false}) end";
						desc = "Buffer Local Keymaps (which-key)";
					}
				]
				++ import ../keys;
		};
	};
}
