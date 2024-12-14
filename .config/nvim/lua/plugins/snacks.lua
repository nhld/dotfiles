---@diagnostic disable:undefined-global
return {
  "folke/snacks.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  -- stylua: ignore
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
  },
  opts = {},
}
