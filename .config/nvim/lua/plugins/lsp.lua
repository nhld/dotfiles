-- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


local config = function()
  -- Switch for controlling whether you want autoformatting.
  --  Use :KickstartFormatToggle to toggle autoformatting on or off
  local format_is_enabled = true
  vim.api.nvim_create_user_command('KickstartFormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
  end, {})

  -- Create an augroup that is used for managing our formatting autocmds.
  --      We need one augroup per client to make sure that multiple clients
  --      can attach to the same buffer without interfering with each other.
  local _augroups = {}
  local get_augroup = function(client)
    if not _augroups[client.id] then
      local group_name = 'kickstart-lsp-format-' .. client.name
      local id = vim.api.nvim_create_augroup(group_name, { clear = true })
      _augroups[client.id] = id
    end

    return _augroups[client.id]
  end

  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = "rounded",
  -- })
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "rounded",
  -- })

  -- See `:help LspAttach` for more information about this autocmd event.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
    -- This is where we attach the autoformatting for reasonable clients
    callback = function(args)
      local client_id = args.data.client_id
      local client = vim.lsp.get_client_by_id(client_id)
      local bufnr = args.buf

      -- Only attach to clients that support document formatting
      if not client.server_capabilities.documentFormattingProvider then
        return
      end

      -- Tsserver usually works poorly. Sorry you work with bad languages
      -- You can remove this line if you know what you're doing :)
      if client.name == 'tsserver' then
        return
      end

      -- Create an autocmd that will run *before* we save the buffer.
      --  Run the formatting command for the LSP that has just attached.
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = get_augroup(client),
        buffer = bufnr,
        callback = function()
          if not format_is_enabled then
            return
          end

          vim.lsp.buf.format {
            async = false,
            filter = function(c)
              return c.id == client.id
            end,
          }
        end,
      })
    end,
  })

  require 'neodev'.setup()
  require('mason').setup()
  require('mason-lspconfig').setup()
  local mason_lspconfig = require 'mason-lspconfig'


  local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  }

  --require('neodev').setup()

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end
  }

  local md_namespace = vim.api.nvim_create_namespace 'n/lsp_float'

  --- Adds extra inline highlights to the given buffer.
  ---@param buf integer
  local function add_inline_highlights(buf)
    for l, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
      for pattern, hl_group in pairs {
        ['@%S+'] = '@parameter',
        ['^%s*(Parameters:)'] = '@text.title',
        ['^%s*(Return:)'] = '@text.title',
        ['^%s*(See also:)'] = '@text.title',
        ['{%S-}'] = '@parameter',
        ['|%S-|'] = '@text.reference',
      } do
        local from = 1 ---@type integer?
        while from do
          local to
          from, to = line:find(pattern, from)
          if from then
            vim.api.nvim_buf_set_extmark(buf, md_namespace, l - 1, from - 1, {
              end_col = to,
              hl_group = hl_group,
            })
          end
          from = to and to + 1 or nil
        end
      end
    end
  end

  --- LSP handler that adds extra inline highlights, keymaps, and window options.
  --- Code inspired from `noice`.
  ---@param handler fun(err: any, result: any, ctx: any, config: any): integer?, integer?
  ---@param focusable boolean
  ---@return fun(err: any, result: any, ctx: any, config: any)
  --
  local function enhanced_float_handler(handler, focusable)
    return function(err, result, ctx, config)
      local bufnr, winnr = handler(
        err,
        result,
        ctx,
        vim.tbl_deep_extend('force', config or {}, {
          border = 'rounded',
          focusable = focusable,
          --max_height = math.floor(vim.o.lines * 0.5),
          --max_width = math.floor(vim.o.columns * 0.4),
        })
      )

      if not bufnr or not winnr then
        return
      end

      -- Conceal everything.
      vim.wo[winnr].concealcursor = 'n'

      -- Extra highlights.
      add_inline_highlights(bufnr)

      -- Add keymaps for opening links.
      if focusable and not vim.b[bufnr].markdown_keys then
        vim.keymap.set('n', 'K', function()
          -- Vim help links.
          local url = (vim.fn.expand '<cWORD>' --[[@as string]]):match '|(%S-)|'
          if url then
            return vim.cmd.help(url)
          end

          -- Markdown links.
          local col = vim.api.nvim_win_get_cursor(0)[2] + 1
          local from, to
          from, to, url = vim.api.nvim_get_current_line():find '%[.-%]%((%S-)%)'
          if from and col >= from and col <= to then
            vim.system({ 'xdg-open', url }, nil, function(res)
              if res.code ~= 0 then
                vim.notify('Failed to open URL' .. url, vim.log.levels.ERROR)
              end
            end)
          end
        end, { buffer = bufnr, silent = true })
        vim.b[bufnr].markdown_keys = true
      end
    end
  end

  --vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  --vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
  -- vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_hover] = enhanced_float_handler(vim.lsp.handlers.hover, true)
  -- vim.lsp.handlers[vim.lsp.protocol.Methods.textDocument_signatureHelp] = enhanced_float_handler(
  -- vim.lsp.handlers.signature_help, false)
  vim.lsp.handlers['textDocument/hover'] = enhanced_float_handler(vim.lsp.handlers.hover, true)
  vim.lsp.handlers['textDocument/signatureHelp'] = enhanced_float_handler(vim.lsp.handlers.signature_help, false)
end


return {
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile", },
  --lazy = false,
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { 'williamboman/mason.nvim',          config = true, },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

    -- Additional lua configuration, makes nvim stuff amazing!
    { 'folke/neodev.nvim' },
  },
  config = config,
}
