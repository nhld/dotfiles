-- Catppuccin
local config = function()
  require("catppuccin").setup {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = true, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = { "italic" },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    highlight_overrides = {
      mocha = function(mocha)
        return {
          ["@punctuation.bracket.lua"] = { fg = mocha.overlay0, style = {} },
          ["@constructor.lua"] = { fg = mocha.overlay0, style = {} },
        }
      end,
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      mini = {
        enabled = true,
        indentscope_color = "",
      },
      navic = {
        enabled = false,
        custom_bg = "NONE", -- "lualine" will set background to mantle
      },
      illuminate = {
        enabled = false,
        lsp = false,
      },
    },
  }

  -- setup must be called before loading
  vim.cmd.colorscheme "catppuccin-mocha"

  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "yellow" })
  -- LSP popup menu
  --vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
  --vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
  --vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })

  -- vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
  -- vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
  -- vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
  --
  -- illuminate word highlight instead of underline
  vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
  vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
  -- auto update the highlight style on colorscheme change
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
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = config,
}

-- TOKYONIGHT
-- local config = function()
--   require("tokyonight").setup {
--     style = "moon",
--     --lualine_bold = true,
--   }
--   require("tokyonight").load()
--   vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "yellow" })
--   -- LSP popup menu
--   --vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
--   --vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
--   --vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
--
--   vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
--   vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
--   vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
--   -- illuminate word highlight
--   vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
--   vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
--   vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
--   --- auto update the highlight style on colorscheme change
--   vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--     pattern = { "*" },
--     callback = function()
--       vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
--       vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
--       vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
--     end,
--   })
-- end
--
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   config = config,
-- }
