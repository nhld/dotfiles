require "util.lsp"

local config = function()
  local servers = {
    clangd = {},
    -- gopls = {},
    eslint = {},
    tsserver = {},
    html = { filetypes = { "html", "twig", "hbs", "ejs" } },
    cssls = {},
    jsonls = {},
    bashls = { filetypes = { "sh", "zsh", "bash" } },
    lua_ls = {
      Lua = {
        runtime = { version = "LUAJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        telemetry = { enable = false },
        diagnostics = { disable = { "missing-fields" } },
        completion = { callSnippet = "Replace" },
      },
    },
  }

  --local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

  require("mason-lspconfig").setup {
    ensure_installed = vim.tbl_keys(servers or {}),
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        require("lspconfig")[server_name].setup {
          cmd = server.cmd,
          capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
          --capabilities = capabilities,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    },
  }

  local lspconfig = require "lspconfig"

  lspconfig.clangd.setup {
    capabilities = {
      offsetEncoding = { "utf-16" }, -- prevent the offset encoding warning
    },
  }

  lspconfig.gopls.setup {
    root_dir = function(fname)
      return require("lspconfig/util").root_pattern("go.work", "go.mod", ".git")(fname) or vim.fn.getcwd()
    end,
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", opts = {} },
    { "williamboman/mason-lspconfig.nvim" },
    { "j-hui/fidget.nvim", opts = {} },
  },
  config = config,
}
