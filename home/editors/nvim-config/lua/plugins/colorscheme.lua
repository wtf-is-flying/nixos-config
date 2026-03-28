return {
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "hard"
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
