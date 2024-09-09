local config = function()
  local cmp = require "cmp"
  local luasnip = require "luasnip"
  local icons = require("config.icons").symbol_kinds
  luasnip.config.setup {}
  require("luasnip.loaders.from_vscode").lazy_load()
  local winhighlight = "Normal:Pmenu,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None"

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    preselect = cmp.PreselectMode.None,
    performance = {
      max_view_entries = 20,
      -- debounce = 0,
      -- throttle = 0,
    },
    window = {
      completion = {
        winhighlight = winhighlight,
      },
      documentation = {
        winhighlight = winhighlight,
      },
    },
    mapping = {
      ["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = false }, { "i", "c" }),
      ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["\\"] = cmp.mapping.close(),
      ["<Tab>"] = {
        i = function(_)
          if cmp.visible() then
            cmp.select_next_item()
          else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
          end
        end,
      },
      ["<S-Tab>"] = {
        i = function(_)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm { select = true }
            else
              cmp.select_prev_item()
            end
          else
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm { select = true }
            end
          end
        end,
      },
    },
    view = {
      entries = {
        follow_cursor = true,
      },
    },
    sources = {
      {
        name = "nvim_lsp",
        -- max_item_count = 100
      },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer" },
    },
    sorting = require "cmp.config.default"().sorting,
    formatting = {
      format = function(entry, item)
        if icons[item.kind] then
          item.kind = string.format("%s %s", icons[item.kind], item.kind)
        end
        -- item.menu = entry.source.name
        local widths = { abbr = 40, menu = 30 }
        for key, width in pairs(widths) do
          if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
            item[key] = string.format("%s%s", vim.fn.strcharpart(item[key], 0, width - 1), "…")
          end
        end
        -- return item
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end,
    },

    cmp.setup.cmdline(":", {
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      preselect = cmp.PreselectMode.None,
      mapping = {
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm { select = false }, { "i", "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Tab>"] = {
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm { select = true }
              else
                cmp.select_next_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm { select = true }
              end
            end
          end,
        },
        ["<S-Tab>"] = {
          c = function(_)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm { select = true }
              else
                cmp.select_prev_item()
              end
            else
              cmp.complete()
              if #cmp.get_entries() == 1 then
                cmp.confirm { select = true }
              end
            end
          end,
        },
      },
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    }),

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    }),
  }
end

return {
  "yioneko/nvim-cmp",
  branch = "perf",
  config = config,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
}
