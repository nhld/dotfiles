-- navic and barbecue
local config = function()
  require("barbecue").setup({
    create_autocmd = false, -- prevent barbecue from updating itself automatically
  })
end

vim.api.nvim_create_autocmd({
  "WinResized", -- or WinResized on NVIM-v0.9 and higher
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",

  -- include this if you have set `show_modified` to `true`
  --"BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function()
    require("barbecue.ui").update()
  end,
})

return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    event = "VeryLazy",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      --"nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = config,
  },

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
}
