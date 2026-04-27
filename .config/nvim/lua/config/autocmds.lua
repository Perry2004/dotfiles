-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- home command
vim.api.nvim_create_user_command("Home", function()
  require("snacks").dashboard.open()
end, { desc = "Open LazyVim Dashboard (Home)" })

vim.api.nvim_create_user_command("BufCloseAll", ":%bd", {
  desc = "Close all listed buffers",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.spell = false
  end,
})
