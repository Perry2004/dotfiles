return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "float",
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,

    start_in_insert = true,
    persist_size = true,
    close_on_exit = true,
    shade_terminals = false,

    float_opts = {
      border = "curved",
    },
  },
  keys = {
    { "<leader>T", "", desc = "+terminal" },
    {
      "<leader>Tf",
      "<cmd>1 ToggleTerm direction=float<CR>",
      desc = "Toggleterm (Floating)",
    },
    {
      "<leader>Tv",
      "<cmd>2 ToggleTerm direction=vertical<CR>",
      desc = "Toggleterm (Vertical)",
    },
    {
      "<leader>Th",
      "<cmd>3 ToggleTerm direction=horizontal<CR>",
      desc = "Toggleterm (Horizontal)",
    },
    {
      "<esc>",
      [[<C-\><C-n>]],
      mode = "t",
      desc = "Exit terminal mode",
    },
  },
}
