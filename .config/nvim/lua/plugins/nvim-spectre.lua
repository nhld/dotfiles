return {
  "nvim-pack/nvim-spectre",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>cs",
      function()
        require("spectre").open()
      end,
      desc = "Search and replace",
    },
  },
}
