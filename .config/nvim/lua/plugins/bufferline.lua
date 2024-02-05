local opts = {
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true, -- use a "true" to enable the default, or set your own character
      },
    },
    diagnostics = "nvim_lsp",
  },
}

local keys = {
  { '[b',         '<cmd>BufferLineCyclePrev<cr>',  desc = 'Previous buffer' },
  { ']b',         '<cmd>BufferLineCycleNext<cr>',  desc = 'Next buffer' },
  { '<leader>bc', '<cmd>BufferLinePickClose<cr>',  desc = 'Select a buffer to close' },
  { '<leader>bl', '<cmd>BufferLineCloseLeft<cr>',  desc = 'Close buffers to the left' },
  { '<leader>bo', '<cmd>BufferLinePick<cr>',       desc = 'Select a buffer to open' },
  { '<leader>br', '<cmd>BufferLineCloseRight<cr>', desc = 'Close buffers to the right' },
}

return {
  "akinsho/bufferline.nvim",
  event = 'VeryLazy',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = opts,
  keys = keys,
}
