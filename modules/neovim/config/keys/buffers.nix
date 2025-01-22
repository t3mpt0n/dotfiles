[
  {
    __unkeyed-1 = "<leader>b";
    group = "Buffers";
    icon = "";
  }

  {
    __unkeyed-1 = "<leader>bn";
    __unkeyed-2 = "<cmd>bn<cr>";
    desc = "Next Buffer";
    icon = "󰒭";
  }
  {
    __unkeyed-1 = "<leader>bp";
    __unkeyed-2 = "<cmd>bp<cr>";
    desc = "Prev. Buffer";
    icon = "󰒮";
  }

  {
    __unkeyed-1 = "<leader>be";
    group = "Empty Buffer";
    icon = "";
  }
  {
    __unkeyed-1 = "<leader>beh";
    __unkeyed-2 = "<cmd>new<cr>";
    desc = "Open in H. Split Window";
    icon = "";
  }
  {
    __unkeyed-1 = "<leader>bev";
    __unkeyed-2 = "<cmd>vnew<cr>";
    desc = "Open in V. Split Window";
    icon = "";
  }
  {
    __unkeyed-1 = "<leader>bew";
    __unkeyed-2 = "<cmd>enew<cr>";
    desc = "Open in Current Window";
    icon = "";
  }
  {
    __unkeyed-1 = "<leader>bet";
    __unkeyed-2 = "<cmd>tabnew<cr>";
    desc = "Open in New Tab";
    icon = "󰏌";
  }

  {
    __unkeyed-1 = "<leader>bd";
    __unkeyed-2 = "<cmd>bd<cr>";
    desc = "Remove Buffer";
    icon = "󰖭";
  }
  {
    __unkeyed-1 = "<leader>bD";
    __unkeyed-2 = "<cmd>bw<cr>";
    desc = "Wipe Buffer (Caution!)";
    icon = "";
  }

  {
    __unkeyed-1 = "<leader>boo";
    __unkeyed-2 = "<cmd>Oil --float .<cr>";
    desc = "Browse Current Directory";
  }
  {
    __unkeyed-1 = "<leader>bof";
    __unkeyed-2.__raw = "function() require'oil'.toggle_float(vim.fn.input('Enter Path => ')) end";
    desc = "Browse given path";
  }
]
