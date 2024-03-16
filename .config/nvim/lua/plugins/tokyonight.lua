-- Theme
local config = function()
  require("tokyonight").setup {
    style = "moon",
    --lualine_bold = true,
  }
  require("tokyonight").load()
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "yellow" })
  -- LSP popup menu
  --vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  --vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
  -- illuminate word highlight
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  --- auto update the highlight style on colorscheme change
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
      vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
    end,
  })
end

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = config,
}
