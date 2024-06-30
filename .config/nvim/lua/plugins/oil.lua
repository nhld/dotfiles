return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function()
    require("oil").setup {
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
    }

    vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
    vim.keymap.set("n", "<space>-", require("oil").toggle_float, { desc = "Open parent dir in floating window" })
  end,
}
