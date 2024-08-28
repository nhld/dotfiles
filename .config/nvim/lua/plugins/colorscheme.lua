return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
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
        integrations = {
          flash = false,
          cmp = true,
          gitsigns = true,
          treesitter = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          telescope = {
            enabled = true,
          },
          neotree = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          semantic_tokens = true,
          treesitter_context = true,
          markdown = true,
        },
      }
      vim.cmd.colorscheme "catppuccin-mocha"

      vim.api.nvim_set_hl(0, "GitAddCount", { fg = "#4fd6be", bg = "#181826" })
      vim.api.nvim_set_hl(0, "GitChangeCount", { fg = "#ffc777", bg = "#181826" })
      vim.api.nvim_set_hl(0, "GitDeleteCount", { fg = "#ff757f", bg = "#181826" })

      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
      vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
      vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
      vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#569cd6" })
      vim.api.nvim_set_hl(0, "WinBar", { link = "EndOfBuffer" })
      vim.api.nvim_set_hl(0, "TreesitterContext", { link = "EndOfBuffer" })
      vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#ffffff" })
    end,
  },

  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      style = "moon",
    },
  },
}
