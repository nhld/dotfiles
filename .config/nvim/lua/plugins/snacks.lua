return {
  "folke/snacks.nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  -- stylua: ignore
  keys = function()
    local Snacks = require"snacks"
    return {
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit", },
    { "]]",         function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev Reference", mode = { "n", "t" } },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
  }
  end,
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    words = { enabled = true },
  },
}
