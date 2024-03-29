local opts = {
  indent = { char = "│" },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
    include = {
      node_type = {
        lua = {
          "chunk",
          "do_statement",
          "while_statement",
          "repeat_statement",
          "if_statement",
          "for_statement",
          "function_declaration",
          "function_definition",
          "table_constructor",
          "assignment_statement",
        },
        typescript = {
          "statement_block",
          "function",
          "arrow_function",
          "function_declaration",
          "method_definition",
          "for_statement",
          "for_in_statement",
          "catch_clause",
          "object_pattern",
          "arguments",
          "switch_case",
          "switch_statement",
          "switch_default",
          "object",
          "object_type",
          "ternary_expression",
        },
      },
    },
  },
}

local config = function()
  local hooks = require "ibl.hooks"
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  require("ibl").setup(opts)
end

return {
  "lukas-reineke/indent-blankline.nvim",
  enabled = false,
  config = config,
  event = "VeryLazy",
  main = "ibl",
}
