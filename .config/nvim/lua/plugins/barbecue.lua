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
  "utilyre/barbecue.nvim",
  enabled = true,
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = config,
}
