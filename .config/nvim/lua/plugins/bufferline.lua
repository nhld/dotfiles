return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local bufferline = require("bufferline")

    bufferline.setup({
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
        --separator_style = { "", "" },
        --modified_icon = "●",
        --show_close_icon = false,
        --show_buffer_close_icons = false,
      },
    })
  end,
}
