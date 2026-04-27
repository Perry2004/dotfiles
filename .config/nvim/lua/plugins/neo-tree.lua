-- collapse directories when possible
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      group_empty_dirs = true,
      scan_mode = "deep",
    },
  },
}
