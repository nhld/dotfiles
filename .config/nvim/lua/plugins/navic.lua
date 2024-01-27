return {
  {
    "SmiteshP/nvim-navic",
    event = "VeryLazy",
    dependencies = {
      'neovim/nvim-lspconfig'
    },
    opts = function()
      return {
        separator = " 〉",
        highlight = true,
        depth_limit = 5,
        -- lsp = {
        --   auto_attach = true,
        -- },
        lazy_update_context = false,
        icons = {
          File = " ",
          Module = " ",
          Namespace = " ",
          Package = " ",
          Class = " ",
          Method = " ",
          Property = " ",
          Field = " ",
          Constructor = " ",
          Enum = " ",
          Interface = " ",
          Function = " ",
          Variable = " ",
          Constant = " ",
          String = " ",
          Number = " ",
          Boolean = " ",
          Array = " ",
          Object = " ",
          Key = " ",
          Null = " ",
          EnumMember = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    --lazy = false,
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  }
}
