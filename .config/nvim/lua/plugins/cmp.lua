local cmp_kinds = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local config = function()
  local cmp = require('cmp')
  local luasnip = require 'luasnip'
  require('luasnip.loaders.from_vscode').lazy_load()
  luasnip.config.setup {}

  cmp.setup {
    preselect = cmp.PreselectMode.None,
    window = {
      documentation = {
        border = 'rounded',
        --winhighlight = 'Normal:NormalFloat,FloatBorder:NormalFloat,Search:None',
        winhighlight = "Normal:CmpNormal,FloatBorder:CmpNormal,Search:None"

      },
      completion = {
        border = 'rounded',
        winhighlight = "Normal:CmpNormal,FloatBorder:CmpNormal,Search:None"
      }
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert,noselect',
    },
    performance = {
      max_view_entries = 10,
    },
    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'buffer' },
    },
    formatting = {
      format = function(_, vim_item)
        vim_item.kind = (cmp_kinds[vim_item.kind] or '') .. vim_item.kind
        return vim_item
      end,
    },
    -- vscode like formating icon first then text
    -- formatting = {
    --   fields = { "kind", "abbr" },
    --   format = function(_, vim_item)
    --     vim_item.kind = cmp_kinds[vim_item.kind] or ""
    --     return vim_item
    --   end,
    -- },
    cmp.setup.cmdline(':', {
      enabled = true,
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
      },
      preselect = cmp.PreselectMode.None,
      mapping = {
        ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      },
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      })
    }),
  }
end

return {
  'hrsh7th/nvim-cmp',
  config = config,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-cmdline'
  },
}
