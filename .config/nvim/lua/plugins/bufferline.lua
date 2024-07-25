local opts = {
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-Tree",
        highlight = "Directory",
        separator = true,
      },
    },
    always_show_bufferline = false,
    truncate_names = false,
    diagnostics = "nvim_lsp",
    numbers = "ordinal",
    close_command = function(bufnr)
      require("mini.bufremove").delete(bufnr, false)
    end,
    show_close_icon = false,
    show_buffer_close_icons = false,
  },
}

local keys = {
  { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
  { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  { "<s-tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
  { "<tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
  { "<leader>bc", "<cmd>BufferLinePickClose<CR>", desc = "Select a buffer to close" },
  { "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
  { "<leader>bo", "<cmd>BufferLinePick<CR>", desc = "Select a buffer to open" },
  { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
  { "<leader>bq", "<cmd>BufferLineCloseOthers<CR>", desc = "Close all buffers except the current" },
  { "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
  { "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
  { "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
  { "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
  { "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
  { "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
  { "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
  { "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>" },
  { "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
}

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = opts,
  keys = keys,
}
