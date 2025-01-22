[
  {
    __unkeyed-1 = "<leader>f";
    group = "Files";
  }

  {
    __unkeyed-1 = "<leader>fs";
    group = "Save File";
    icon = "󰆓";
  }
  {
    __unkeyed-1 = "<leader>fss";
    __unkeyed-2 = "<cmd>w<cr>";
    desc = "Save File & Stay";
    icon = "";
  }
  {
    __unkeyed-1 = "<leader>fsq";
    __unkeyed-2 = "<cmd>x<cr>";
    desc = "Save File & Exit";
    icon = "󰸧";
  }

  {
    __unkeyed-1 = "<leader>ff";
    __unkeyed-2 = "<cmd>Telescope find_files<cr>";
    desc = "Find Files in Current Dir.";
    icon = "󰈞";
  }

  {
    __unkeyed-1 = "<leader>fl";
    __unkeyed-2.__raw = "function() require'lint'.try_lint() end";
    desc = "Trigger Linting for Current File";
  }
]
