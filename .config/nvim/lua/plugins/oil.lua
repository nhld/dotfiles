return {
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil current dir" },
    { "_", "<cmd>Oil .<cr>", desc = "Oil root dir" },
  },
  opts = {
    view_options = {
      show_hidden = true,
    },
    delete_to_trash = true,
  },
}
