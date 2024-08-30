return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = true,
    no_underline = false,
    styles = {
      comments = { "italic" },
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
      miscs = {},
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
  },
  init = function()
    vim.cmd.colorscheme "catppuccin-mocha"

    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4fd6be" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ffc777" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff757f" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { fg = "#569cd6" })
    vim.api.nvim_set_hl(0, "WinBar", { link = "EndOfBuffer" })
    vim.api.nvim_set_hl(0, "TreesitterContext", { link = "EndOfBuffer" })
    vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { fg = "#ffffff" })
  end,
}
