-- No config or very short config plugins
return {
  { "tpope/vim-sleuth", event = "VeryLazy" },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
}
