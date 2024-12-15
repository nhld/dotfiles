return {
  "folke/snacks.nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  ---@diagnostic disable:undefined-global
  -- stylua: ignore
  keys = {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
    { "]]",         function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference", mode = { "n", "t" } },
  },
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
  },
}
