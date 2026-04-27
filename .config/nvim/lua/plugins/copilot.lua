return {
  "github/copilot.vim",
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_no_panel_maps = true
  end,

  config = function()
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot Prev" })
    vim.keymap.set("i", "<Tab>", 'copilot#Accept("<Tab>")', { expr = true, silent = true })
  end,
}
