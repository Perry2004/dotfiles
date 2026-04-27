return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- 2. Configure Catppuccin using the defaults you provided,
  --    but adding the auto-switching logic.
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000, -- Make sure this loads first
    opts = {
      flavour = "auto",
      background = {
        light = "day",
        dark = "storm",
      },
    },
  },

  -- 3. Add the plugin to sync with the macOS system theme
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false, -- Make sure this plugin loads on startup
    priority = 1001, -- Load after Catppuccin
    config = function()
      require("auto-dark-mode").setup({
        -- This function runs when "dark" mode is detected
        set_dark_mode = function()
          vim.o.background = "dark"
        end,
        -- This function runs when "light" mode is detected
        set_light_mode = function()
          vim.o.background = "light"
        end,
      })
    end,
  },
}
