return {
  "nvchad/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup {
      user_default_options = {
        tailwind = true,
      },
      filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
      },
    }
  end,
}
