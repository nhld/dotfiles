return {
  "akinsho/bufferline.nvim",
  event = 'VeryLazy',
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
      },
    })
  end,
}
