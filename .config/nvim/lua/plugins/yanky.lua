return {
  "gbprod/yanky.nvim",
  keys = {
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
    { "=p", "<Plug>(YankyPutAfterLinewise)", desc = "Put yanked text in line below" },
    { "=P", "<Plug>(YankyPutBeforeLinewise)", desc = "Put yanked text in line above" },
    { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
    { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
    { "<leader>yy", ":Telescope yank_history<CR>", desc = "Yank history" },
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yanky Yank" },
  },
  opts = {
    ring = { history_length = 20 },
    highlight = { timer = 250 },
  },
}
