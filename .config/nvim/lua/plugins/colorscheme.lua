local catppuccin_config = function()
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
    -- highlight_overrides = {
    --   mocha = function(mocha)
    --     return {
    --       ["@punctuation.bracket.lua"] = { fg = mocha.overlay0, style = {} },
    --       ["@constructor.lua"] = { fg = mocha.mauve, style = {} },
    --     }
    --   end,
    -- },
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
end

local tokyonight_config = function()
  require("tokyonight").setup {
    style = "moon",
    lualine_bold = true,
  }
  vim.cmd.colorscheme "tokyonight-moon"

  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "yellow" })
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#636da6" })

  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
end

return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = catppuccin_config,
    enabled = false,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = tokyonight_config,
  },
}
