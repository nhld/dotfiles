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
