local config = function()
  require('onedark').setup({
    style = 'darker'
  })
  require('onedark').load()

  vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
  vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
end

return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,
  config = config,
}

--return {
-- 'tjdevries/gruvbuddy.nvim',
-- dependencies = { 'tjdevries/colorbuddy.vim' },
-- lazy = false,
-- priority = 1000,
-- config = function()
--   require('colorbuddy').colorscheme('gruvbuddy')
-- end
--}
