return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "*",
  opts = {
    keymap = { preset = "default" },
    completion = {
      list = {
        selection = { preselect = false, auto_insert = true },
        max_items = 15,
      },
      documentation = {
        auto_show = true,
      },
      menu = {
        draw = {
          align_to = "cursor",
        },
      },
    },
    signature = { enabled = true },
    cmdline = {
      completion = { menu = { auto_show = true } },
    },
  },

  snippets = { preset = "luasnip" },
  appearance = {
    -- kind_icons = require("config.icons").symbol_kinds,
  },
  config = function(_, opts)
    require("blink.cmp").setup(opts)
    vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities(nil, true) })
  end,
}
