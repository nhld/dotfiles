return {
  'navarasu/onedark.nvim',
  --event = "VeryLazy",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
    require('onedark').setup({
      style = 'darker'
    })
    require('onedark').load()
    vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  end,
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
